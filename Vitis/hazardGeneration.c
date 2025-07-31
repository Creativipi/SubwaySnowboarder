#include "hazardGeneration.h"

void generateObstacle(int tileX, int tileY, Positions* obstacleHitZone) {
    // Generate a random hazard type for the obstacle
    obstacleHitZone->hazardType = (HazardType)(rand() % (Mega_Rock + 1));
    obstacleHitZone->tileX = tileX;
    obstacleHitZone->rmvTileY = tileY;

    int asymetrical = (rand() % 2); // Randomly chooses where an asymmetrical obstacle will be placed
    int setBackTile;
    switch (obstacleHitZone->hazardType) {
    case Mini_Tree:
        setBackTile = cmdGenSetBackTile(18, true, tileX + 4, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX * 8 + 4;
        obstacleHitZone->y = tileY * 8;
        break;
        
    case Big_Tree:
        setBackTile = cmdGenSetBackTile(12, true, tileX + 3 + asymetrical, tileY - 2, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(13, true, tileX + 4 + asymetrical, tileY - 2, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        setBackTile = cmdGenSetBackTile(14, true, tileX + 3 + asymetrical, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(15, true, tileX + 4 + asymetrical, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        setBackTile = cmdGenSetBackTile(16, true, tileX + 3 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(17, true, tileX + 4 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX + 3 + asymetrical;
        obstacleHitZone->y = tileY - 2;
        break;

    case Fat_Rock:
        setBackTile = cmdGenSetBackTile(3, true, tileX + 3, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(4, true, tileX + 4, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(5, true, tileX + 5, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX + 3;
        obstacleHitZone->y = tileY;
        break;

    case Mini_Rock:
        setBackTile = cmdGenSetBackTile(3, true, tileX + 3 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(5, true, tileX + 4 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX + 3 + asymetrical;
        obstacleHitZone->y = tileY;
        break;

    case Square_Rock:
        setBackTile = cmdGenSetBackTile(6, true, tileX + 3 + asymetrical, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(5, true, tileX + 4 + asymetrical, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        setBackTile = cmdGenSetBackTile(7, true, tileX + 3 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(8, true, tileX + 4 + asymetrical, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX + 3 + asymetrical;
        obstacleHitZone->y = tileY - 1;
        break;

    case Mega_Rock:
        setBackTile = cmdGenSetBackTile(6, true, tileX + 4, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(5, true, tileX + 5, tileY - 1, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        setBackTile = cmdGenSetBackTile(3, true, tileX + 3, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(7, true, tileX + 4, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        setBackTile = cmdGenSetBackTile(8, true, tileX + 5, tileY, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);

        obstacleHitZone->x = tileX + 4;
        obstacleHitZone->y = tileY - 1;
        break;
    }
}

void deleteObstacle(int tileX, int tileY) {
    int setBackTile;
    for (int i = 0; i <= 4; i++) {
        for (int j = 0; j <= 4; j++) {
            setBackTile = cmdGenSetBackTile(0, true, tileX + 2 + i, tileY - j, false, false);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
        }
    }
}