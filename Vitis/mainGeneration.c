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

int columnDividerColorTileChoice(char color, bool isFirstIteration, bool newLine) {
    int tileId;
    if (color == 'r') {
        if (isFirstIteration || newLine) {
            tileId = 10;
        } else {
            tileId = 2;
        }
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

    const int COL_WIDTH = 6; // Width of each column in tiles
    const int SPACE_BETWEEN_OBSTACLES_ROWS = 128; // Space between obstacles in rows in pixels, must be a multiple of 2

    int currentLine = 0;
	int flag = 0;
    int jumpStartX;
	int setBackTile;
	int tileX = 0;
	int newTileY = 0;
	int rmvTileY = 0;

    int numLines = 3;
    int globalCounter = 0;
    int bitIndex;
    bool generateObstacle;
    int previousNumLines = 0;
    bool isFirstIteration = true;

    PositionArray hazards;
    initArray(&hazards, 2); // Initialize the hazard array

    usleep(100000);

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
            currentLine = 0;
        } else {
            flag = 0;
        }

        jumpStartX = ((13 - numLines) / 2) * COL_WIDTH;
        if (flag == 1) {
            // printf("Viewport Y: %d\n", viewportY);
            // printf("New Tile Y: %d, Remove Tile Y: %d\n", newTileY, rmvTileY);

            int obstacleMask = generateObstacleMask(globalCounter/100000.0f, &numLines, 0);
            tileX = jumpStartX;
            while (currentLine < numLines) {
                if (currentLine != 0) {
                    tileX += COL_WIDTH;
                }

                bitIndex = (numLines - 1) - currentLine;
                generateObstacle = (obstacleMask >> bitIndex) & 1;

                if (generateObstacle) {
                    Positions obstacleHitZone;
                    obstacleHitZone.x = tileX;
                    obstacleHitZone.y = newTileY;
                    obstacleHitZone.height = 16;
                    obstacleHitZone.width = 24;
                    obstacleHitZone.hazard = Rock;
                    push(&hazards, obstacleHitZone);

                    setBackTile = cmdGenSetBackTile(6, true, tileX + 4, newTileY, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(5, true, tileX + 5, newTileY, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(3, true, tileX + 3, newTileY + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(7, true, tileX + 4, newTileY + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(8, true, tileX + 5, newTileY + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
                }

                currentLine++;
            }

            for (int i = 0; i < hazards.size; i++) {
                if (hazards.data[i].y == rmvTileY) {
                    setBackTile = cmdGenSetBackTile(0, true, hazards.data[i].x + 4, hazards.data[i].y, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(0, true, hazards.data[i].x + 5, hazards.data[i].y, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(0, true, hazards.data[i].x + 3, hazards.data[i].y + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(0, true, hazards.data[i].x + 4, hazards.data[i].y + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    setBackTile = cmdGenSetBackTile(0, true, hazards.data[i].x + 5, hazards.data[i].y + 1, false, false);
                    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

                    deleteAt(&hazards, i);
                    i--; // Adjust index after deletion
                }
            }

            // printf("Hazards Size: %d\n", hazards.size);
        }

        int columnDividerX;
        bool newLine = false;
        if (numLines != previousNumLines) {
            newLine = true;
        }

        while (currentLine < numLines) {
            if (currentLine == 0) {
                columnDividerX = jumpStartX + 1;
                setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('r', isFirstIteration, newLine), true, columnDividerX, viewportY - SPACE_BETWEEN_OBSTACLES_ROWS, false, false);
            } else if (currentLine == numLines - 1) {
                columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLine);
                setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('r', isFirstIteration, newLine), true, columnDividerX, viewportY - SPACE_BETWEEN_OBSTACLES_ROWS, false, false);
            } else {
                columnDividerX = jumpStartX + 1 + (COL_WIDTH * currentLine);
                setBackTile = cmdGenSetBackTile(columnDividerColorTileChoice('b', isFirstIteration, newLine), true, columnDividerX, viewportY - SPACE_BETWEEN_OBSTACLES_ROWS, false, false);
            }
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        }
        isFirstIteration = false;
        previousNumLines = numLines;
        
        viewportY--;
		if (viewportY < 0) {
			viewportY = 1023;
		}
        globalCounter++;

        usleep(10000);
    }

    return 0;
}