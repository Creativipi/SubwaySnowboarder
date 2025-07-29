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

int main() {
    configureScaler();
    configureVdma();

    int setView;
	int viewportY = 1023; // Start at the maximum value for y

    int currentLine = 0;
	int flag = 0;
	int setBackTile;
	int tileX = 0;
	int newTileY = 0;
	int rmvTileY = 0;

    int numLines;
    int globalCounter = 0;
    int bitIndex;
    bool generateObstacle;

    PositionArray hazards;
    initArray(&hazards, 2); // Initialize the hazard array

    usleep(100000);

    while(1) {
		setView = cmdGenSetView(4, viewportY);
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setView);

        if (viewportY % 64 == 0) {
            newTileY = viewportY - 64;
            rmvTileY = viewportY + 384; // 384 = 6 * 64 donc 7 rangées existent en même temps

            if (viewportY == 0) {
                newTileY += 1024; // Adjust for the wrap-around
            } else if (viewportY >= 640){
                rmvTileY -= 1024; // Adjust for the wrap-around
            }

            newTileY = newTileY/8; // Convert to tile Y
            rmvTileY = rmvTileY/8; // Convert to tile Y

            flag = 1;
            currentLine = 0;
        } else {
            flag = 0;
        }
		
        if (flag == 1) {
            // printf("Viewport Y: %d\n", viewportY);
            // printf("New Tile Y: %d, Remove Tile Y: %d\n", newTileY, rmvTileY);

            int obstacleMask = generateObstacleMask(globalCounter/100000.0f, &numLines);
            tileX = ((13 - numLines) / 2) * 6;
            while (currentLine <= numLines - 1) {
                if (currentLine != 0) {
                    tileX += 6;
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
        
        viewportY--;
		if (viewportY < 0) {
			viewportY = 1023;
		}
        globalCounter++;

        usleep(10000);
    }

    return 0;
}