#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#include "xtime_l.h"

#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"
#include "sleep.h"
#include "toVivado.h"
#include "randomGenerator.h"
#include "dynamicArrayHazards.h"
#include "hazardGeneration.h"
#include "dynamicArrayActors.h"
#include "actorsMovements.h"

int columnDividerColorTileChoice(char color, bool isFirstIteration, bool newLine) {
    int tileId;
    switch (color) {
    case 'r':
        if (isFirstIteration || newLine) {
            tileId = 10;
        } else {
            tileId = 2;
        }
        break;
    case 't':
        tileId = 11;
        break;
    case 'b':
        if (isFirstIteration) {
            tileId = 9;
        } else {
            tileId = 1;
        }
        break;
    }
    return tileId;
}

int main() {
    configureScaler();
    configureVdma();

    XTime t;
    XTime_GetTime(&t);   // Get current timer value
    srand((unsigned int)t); // Use it to seed rand()

    sleep(1);

    while(1) {
        int setView;
        int viewportY = 1023; // Start at the maximum value for y

        const int TILE_SIZE = 8; // Size of each tile in pixels
        const int COL_WIDTH = 6; // Width of each column in tiles
        const int SPACE_BETWEEN_OBSTACLES_ROWS = 128; // Space between obstacles in rows in pixels, must be a multiple of 2
        const int SPACE_BETWEEN_COLUMN_DIVIDERS_SPAWN_AND_MAIN_ACTOR = 400; // Space between column dividers's spawn and main actor in pixels
        const int ACTOR_WIDTH = 16;
        const int ACTOR_HEIGHT = 16;

        int currentLineObstacles = 0;
        int flag = 0;
        int jumpStartX = 5 * COL_WIDTH;
        int setBackTile;
        int tileX = 0;
        int newTileY = 0;
        int rmvTileY = 0;
        int newColumnDividerY = 0;

        int numLines = 3;
        int globalCounter = 0;

        int currentLineColumnDivider = 0;
        int previousNumLines = 3;
        bool isFirstIteration = true;

        int currentLineSubways = 0;

        int newPosRedColumnDividers[2] = {((jumpStartX + 1) * 8) + 7, (jumpStartX + 1 + (COL_WIDTH * 3)) * 8};
        int currentPosRedColumnDividers[2] = {((jumpStartX + 1) * 8) + 7, (jumpStartX + 1 + (COL_WIDTH * 3)) * 8};
        int counterUpdateCurrentPosRedColumnDividers = 0;
        int numTimesMoveMainActor = 0;
        int directionMainActor;
        bool triedTurningLeft = false;
        bool triedTurningRight = false;

        bool wasHit = false;
        int immunityCounter = 0;
        int setActTile;
        int setActPos;

        int pv = 50; // Player's health points

        ActorArray mainActor;
        initActorArray(&mainActor, 2); // Initialize the main actor array with a capacity
        initializeActors(&mainActor);
        resetBackground();

        PositionArray hazards;
        initArray(&hazards, 2); // Initialize the hazard array

        ActorArray subways;
        initActorArray(&subways, 2); // Initialize the subway array

        while(pv > 0) {
            setView = cmdGenSetView(4, viewportY);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setView);

            if (viewportY % SPACE_BETWEEN_OBSTACLES_ROWS == 0) {
                newTileY = viewportY - (SPACE_BETWEEN_OBSTACLES_ROWS * 2); // 128 * 2 donc 2 rangées avant le viewport
                rmvTileY = viewportY + (SPACE_BETWEEN_OBSTACLES_ROWS * 3); // 128 * 3 donc 3 rangées dans le viewport

                if (newTileY < 0) {
                    newTileY += 1024; // Adjust for the wrap-around
                } else if (rmvTileY > 1023){
                    rmvTileY -= 1024; // Adjust for the wrap-around
                }

                newTileY = newTileY/8; // Convert to tile Y
                rmvTileY = rmvTileY/8; // Convert to tile Y

                flag = 1;
                currentLineObstacles = 0;
                currentLineSubways = 0;
            } else {
                flag = 0;
            }

            if (flag == 1) {
                int obstacleMask = generateObstacleMask(globalCounter/50000.0f, &numLines, 0);
                jumpStartX = ((13 - numLines) / 2) * COL_WIDTH;
                tileX = jumpStartX;
                while (currentLineObstacles < numLines) {
                    int bitIndex = (numLines - 1) - currentLineObstacles;
                    bool doGenerateObstacle = (obstacleMask >> bitIndex) & 1;

                    if (doGenerateObstacle) {
                        Positions obstacle;
                        generateObstacle(tileX, newTileY, &obstacle);
                        pushHazard(&hazards, obstacle);
                    }

                    tileX += COL_WIDTH;
                    currentLineObstacles++;
                }

                for (int i = 0; i < hazards.size; i++) {
                    if (hazards.data[i].rmvTileY == rmvTileY) {
                        deleteObstacle(hazards.data[i].tileX, hazards.data[i].rmvTileY);
                        deleteHazardAt(&hazards, i);
                        i--; // Adjust index after deletion
                    }
                }

                int subwayMask = generateSubwayMask(numLines);
                tileX = jumpStartX;
                while (currentLineSubways < numLines) {
                    int bitIndex = (numLines - 1) - currentLineSubways;
                    bool doGenerateSubway = (subwayMask >> bitIndex) & 1;

                    if (doGenerateSubway) {
                        Actor subway;
                        generateSubway(tileX, newTileY + 8, &subway, subways.size + 2);
                        pushActor(&subways, subway);
                    }

                    tileX += COL_WIDTH;
                    currentLineSubways++;
                }

                for (int i = 0; i < subways.size; i++) {
                    if (((subways.data[i].yBackground + 8) / 8) - 8 == rmvTileY) {
                        deleteSubway(&subways, i);
                        i--; // Adjust index after deletion
                    }
                }
            }

            if (viewportY % TILE_SIZE == 0) {
                int columnDividerX;
                bool newLine = false;
                if (numLines != previousNumLines) {
                    newLine = true;
                }

                newColumnDividerY = viewportY - SPACE_BETWEEN_OBSTACLES_ROWS;
                if (newColumnDividerY < 0) {
                    newColumnDividerY += 1024; // Adjust for the wrap-around
                }
                newColumnDividerY = newColumnDividerY/8; // Convert to tile Y

                currentLineColumnDivider = 0;
                while (currentLineColumnDivider < numLines + 1) {
                    if (currentLineColumnDivider == 0) {
                        columnDividerX = jumpStartX + 1;
                        newPosRedColumnDividers[0] = columnDividerX * 8 + 7; // Update the red line position
                        setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('r', isFirstIteration, newLine), true, columnDividerX, newColumnDividerY, false, false);
                    } else if (currentLineColumnDivider == numLines) {
                        columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLineColumnDivider);
                        newPosRedColumnDividers[1] = columnDividerX * 8; // Update the red line position
                        setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('r', isFirstIteration, newLine), true, columnDividerX, newColumnDividerY, false, false);
                    } else if (newLine && (currentLineColumnDivider == 1 || currentLineColumnDivider == numLines - 1)) {
                        columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLineColumnDivider);
                        setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('t', isFirstIteration, newLine), true, columnDividerX, newColumnDividerY, false, false);
                    } else {
                        columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLineColumnDivider);
                        setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('b', isFirstIteration, newLine), true, columnDividerX, newColumnDividerY, false, false);
                    }
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
                    currentLineColumnDivider++;
                }
                isFirstIteration = false;
                previousNumLines = numLines;
            }

            if (newPosRedColumnDividers[0] != currentPosRedColumnDividers[0] || newPosRedColumnDividers[1] != currentPosRedColumnDividers[1]) {
                counterUpdateCurrentPosRedColumnDividers++;
                if (counterUpdateCurrentPosRedColumnDividers >= SPACE_BETWEEN_COLUMN_DIVIDERS_SPAWN_AND_MAIN_ACTOR) {
                    currentPosRedColumnDividers[0] = newPosRedColumnDividers[0];
                    currentPosRedColumnDividers[1] = newPosRedColumnDividers[1];
                    counterUpdateCurrentPosRedColumnDividers = 0;
                }
            }

            if (((viewportY + 64) % SPACE_BETWEEN_OBSTACLES_ROWS == 0) || numTimesMoveMainActor != 0) {
                if (numTimesMoveMainActor == 0) {
                    directionMainActor = rand() % 3; // From 0 to 2
                    if (directionMainActor == 0 && (mainActor.data[0].xBackground - currentPosRedColumnDividers[0]) < 14) {
                        directionMainActor = 1; // Change direction to straight if too close to the left red line
                        triedTurningLeft = true;
                    } else if (directionMainActor == 2 && (currentPosRedColumnDividers[1] - (mainActor.data[0].xBackground + 15)) < 14) {
                        directionMainActor = 1; // Change direction to straight if too close to the right red line
                        triedTurningRight = true;
                    }
                }

                moveMainActor(directionMainActor, numTimesMoveMainActor, triedTurningLeft, triedTurningRight, &mainActor);
                numTimesMoveMainActor++;
                if (numTimesMoveMainActor > 25) {
                    numTimesMoveMainActor = 0;
                    triedTurningLeft = false;
                    triedTurningRight = false;
                }
            }

            if (!wasHit) {
                for (int i = 0; i < hazards.size; i++) {
                    for (int j = 0; j < mainActor.size; j++) {
                        if (!(hazards.data[i].x + hazardDimensions[hazards.data[i].hazardType].width <= mainActor.data[j].xBackground
                            || mainActor.data[j].xBackground + ACTOR_WIDTH <= hazards.data[i].x
                            || hazards.data[i].y + hazardDimensions[hazards.data[i].hazardType].height <= mainActor.data[j].yBackground
                            || mainActor.data[j].yBackground + ACTOR_HEIGHT <= hazards.data[i].y)) { // Checks for collision
                                wasHit = true;
                                pv -= 1; // Decrease player's health points
                        }
                    }
                }
            } else {
                if (immunityCounter < 15 || (immunityCounter > 29 && immunityCounter < 45) || (immunityCounter > 59 && immunityCounter < 75)) {
                    setActTile = cmdGenSetActTile(mainActor.data[0].actorIndex, true, 8, false, false, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
                    setActTile = cmdGenSetActTile(mainActor.data[1].actorIndex, true, 8, false, false, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
                } else if ((immunityCounter > 14 && immunityCounter < 30) || (immunityCounter > 44 && immunityCounter < 60) || immunityCounter > 74) {
                    setActTile = cmdGenSetActTile(mainActor.data[0].actorIndex, true, mainActor.data[0].tile, false, false, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
                    setActTile = cmdGenSetActTile(mainActor.data[1].actorIndex, true, mainActor.data[1].tile, false, false, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
                }

                if (immunityCounter > 74) {
                    immunityCounter = 0; // Reset immunity counter after a certain time
                    wasHit = false; // Reset hit status
                } else {
                    immunityCounter++;
                }
            }

            for (int i = 0; i < subways.size; i++) {
                for (int j = 0; j < mainActor.size; j++) {
                    if (!(subways.data[i].xBackground + ACTOR_WIDTH <= mainActor.data[j].xBackground
                        || mainActor.data[j].xBackground + ACTOR_WIDTH <= subways.data[i].xBackground
                        || subways.data[i].yBackground + ACTOR_HEIGHT <= mainActor.data[j].yBackground
                        || mainActor.data[j].yBackground + ACTOR_HEIGHT <= subways.data[i].yBackground)) {
                            deleteSubway(&subways, i);
                            pv += 5; // Increase player's health points
                    }
                }
            }

            viewportY--;
            if (viewportY < 0) {
                viewportY += 1024; // Wrap around if it goes below 0
            }

            for (int i = 0; i < subways.size; i++) {
                if (viewportY % 8 == 0) {
                    subwayAnimation(&subways, i);
                }

                subways.data[i].yViewport++;
                setActPos = cmdGenSetActPos(subways.data[i].actorIndex, true, subways.data[i].xViewport, subways.data[i].yViewport, false, subways.data[i].flipX, false, subways.data[i].flipY);
                MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
            }

            for (int i = 0; i < mainActor.size; i++) {
                mainActor.data[i].yBackground--;
                if (mainActor.data[i].yBackground < 0) {
                    mainActor.data[i].yBackground += 1024; // Wrap around if it goes below 0
                }
            }

            globalCounter++;

            usleep(10000);
        }
        freeActorArray(&mainActor);
        freeArray(&hazards);
        freeActorArray(&subways);
        resetBackground();
    }

    return 0;
}