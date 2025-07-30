#include <stdio.h>
#include <stdbool.h>

#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"
#include "sleep.h"
#include "toVivado.h"
#include "randomObstacleGenerator.h"
#include "dynamicArrayHazards.h"
#include "hazardGeneration.h"

int columnDividerColorTileChoice(char color, bool isFirstIteration, bool newLine) {
    int tileId;
    if (color == 'r') {
        if (isFirstIteration || newLine) {
            tileId = 10;
        } else {
            tileId = 2;
        }
    } else if (color == 't') {
        tileId = 11;
    } else if (color == 'b') {
        if (isFirstIteration) {
            tileId = 9;
        } else {
            tileId = 1;
        }
    }
    return tileId;
}

int main() {
    configureScaler();
    configureVdma();

    int setView;
	int viewportY = 1023; // Start at the maximum value for y

    const int TILE_SIZE = 8; // Size of each tile in pixels
    const int COL_WIDTH = 6; // Width of each column in tiles
    const int SPACE_BETWEEN_OBSTACLES_ROWS = 128; // Space between obstacles in rows in pixels, must be a multiple of 2

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
    int bitIndex;
    bool doGenerateObstacle;

    int currentLineColumnDivider = 0;
    int previousNumLines = 3;
    bool isFirstIteration = true;

    int moveActPos;
    int setActPos;
    int setActTile;
    // Define actor position sequence
    int actor_positions[3] = {
        100,
        200,
        300
    };
    int actorPosIncrementer = 0;

    PositionArray hazards;
    initArray(&hazards, 2); // Initialize the hazard array

    sleep(1);

    while(1) {
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
        } else {
            flag = 0;
        }

        if (flag == 1) {
            int obstacleMask = generateObstacleMask(globalCounter/100000.0f, &numLines, 0);
            jumpStartX = ((13 - numLines) / 2) * COL_WIDTH;
            tileX = jumpStartX;
            while (currentLineObstacles < numLines) {
                if (currentLineObstacles != 0) {
                    tileX += COL_WIDTH;
                }

                bitIndex = (numLines - 1) - currentLineObstacles;
                doGenerateObstacle = (obstacleMask >> bitIndex) & 1;

                if (doGenerateObstacle) {
                    Positions obstacleHitZone;
                    generateObstacle(tileX, newTileY, &obstacleHitZone);
                    push(&hazards, obstacleHitZone);
                }

                currentLineObstacles++;
            }

            for (int i = 0; i < hazards.size; i++) {
                if (hazards.data[i].rmvTileY == rmvTileY) {
                    deleteObstacle(hazards.data[i].tileX, hazards.data[i].rmvTileY);
                    deleteAt(&hazards, i);
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
                    setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('r', isFirstIteration, newLine), true, columnDividerX, newColumnDividerY, false, false);
                } else if (currentLineColumnDivider == numLines) {
                    columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLineColumnDivider);
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

        // Every 300 frames, update actor position
        if (globalCounter % 300 == 0)
        {
            globalCounter = 0;
            int ax = actor_positions[i] & 0x3FF;
            int ay = actor_positions[i] & 0x3FF;

            int instruction = (0x3 << 28) | (0x0 << 25) | (1 << 24) | (ax << 14) | (ay << 4);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, instruction);

            actorPosIncrementer = (actorPosIncrementer + 1) % 3;
        }
        
        viewportY--;
		if (viewportY < 0) {
			viewportY = 1023;
		}
        globalCounter++;

        usleep(10000);
    }

    return 0;
}