#include "actorsMovements.h"

const int VIEWPORT_WIDTH = 640; // Width of the viewport in pixels
const int VIEWPORT_HEIGHT = 360; // Height of the viewport in pixels

void initializeActors(ActorArray* mainActor) {
    int setActTile;
    int setActPos;

    mainActor->data[0].tile = 1;
    mainActor->data[0].flipX = false;
    mainActor->data[0].flipY = false;
    mainActor->data[0].xViewport = (VIEWPORT_WIDTH / 2 - 7) - 1; // Centered in the viewport
    mainActor->data[0].yViewport = (VIEWPORT_HEIGHT * (4.0 / 5.0) - 16) - 1;
    mainActor->data[0].xBackground = mainActor->data[0].xViewport + 4;
    mainActor->data[0].yBackground = mainActor->data[0].yViewport - 1;
    setActTile = cmdGenSetActTile(0, true, mainActor->data[0].tile, false, mainActor->data[0].flipX, false, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(0, true, mainActor->data[0].xViewport, mainActor->data[0].yViewport, false, mainActor->data[0].flipX, false, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);

    mainActor->data[1].tile = 2;
    mainActor->data[1].flipX = false;
    mainActor->data[1].flipY = false;
    mainActor->data[1].xViewport = (VIEWPORT_WIDTH / 2 - 7) - 1; // Centered in the viewport
    mainActor->data[1].yViewport = (VIEWPORT_HEIGHT * (4.0 / 5.0)) - 1;
    mainActor->data[1].xBackground = mainActor->data[1].xViewport + 4;
    mainActor->data[1].yBackground = mainActor->data[1].yViewport - 1;
    setActTile = cmdGenSetActTile(1, true, mainActor->data[1].tile, false, mainActor->data[1].flipX, false, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(1, true, mainActor->data[1].xViewport, mainActor->data[1].yViewport, false, mainActor->data[1].flipX, false, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);

    for (int i = 2; i < 8; i++) {
        setActPos = cmdGenSetActPos(i, true, 700, 700, false, false, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
    }
}

void moveMainActor(int direction, int numTimes, bool triedTurning, ActorArray* mainActor) {
    int setActTile;
    int setActPos;

    switch (direction) {
        case 0: // Left
            if (numTimes == 0) {
                mainActor->data[0].tile = 3;
                mainActor->data[0].flipX = true;
                mainActor->data[0].xViewport -= 9;
                mainActor->data[0].yViewport += 9;
                mainActor->data[0].xBackground -= 9;
                mainActor->data[0].yBackground += 9;

                mainActor->data[1].tile = 4;
                mainActor->data[1].flipX = true;
            } else if (numTimes == 9) {
                mainActor->data[0].tile = 1;
                mainActor->data[0].flipX = false;
                mainActor->data[0].xViewport += 9;
                mainActor->data[0].yViewport -= 9;
                mainActor->data[0].xBackground += 9;
                mainActor->data[0].yBackground -= 9;

                mainActor->data[1].tile = 2;
                mainActor->data[1].flipX = false;
            } else {
                mainActor->data[0].xViewport -= 6;
                mainActor->data[0].xBackground -= 6;

                mainActor->data[1].xViewport -= 6;
                mainActor->data[1].xBackground -= 6;
            }
            break;
        case 1: // Straight
            if (triedTurning) {
                if (numTimes % 2 == 0) {
                    if (numTimes == 0) {
                        mainActor->data[0].xViewport -= 9;
                        mainActor->data[0].yViewport += 9;
                        mainActor->data[0].xBackground -= 9;
                        mainActor->data[0].yBackground += 9;
                    } else {
                        mainActor->data[0].xViewport -= 18;
                        mainActor->data[0].xBackground -= 18;
                    }
                    mainActor->data[0].tile = 3;
                    mainActor->data[0].flipX = true;

                    mainActor->data[1].tile = 4;
                    mainActor->data[1].flipX = true;
                } else if (numTimes == 9) {
                    mainActor->data[0].tile = 1;
                    mainActor->data[0].flipX = false;
                    mainActor->data[0].xViewport += 9;
                    mainActor->data[0].yViewport -= 9;
                    mainActor->data[0].xBackground += 9;
                    mainActor->data[0].yBackground -= 9;

                    mainActor->data[1].tile = 2;
                    mainActor->data[1].flipX = false;
                } else {
                    mainActor->data[0].tile = 3;
                    mainActor->data[0].flipX = false;
                    mainActor->data[0].xViewport += 18;
                    mainActor->data[0].xBackground += 18;

                    mainActor->data[1].tile = 4;
                    mainActor->data[1].flipX = false;
                }
            }
            break;
        case 2:  // Right
            if (numTimes == 0) {
                mainActor->data[0].tile = 3;
                mainActor->data[0].xViewport += 9;
                mainActor->data[0].yViewport += 9;
                mainActor->data[0].xBackground += 9;
                mainActor->data[0].yBackground += 9;

                mainActor->data[1].tile = 4;
            } else if (numTimes == 9) {
                mainActor->data[0].tile = 1;
                mainActor->data[0].xViewport -= 9;
                mainActor->data[0].yViewport -= 9;
                mainActor->data[0].xBackground -= 9;
                mainActor->data[0].yBackground -= 9;

                mainActor->data[1].tile = 2;
            } else {
                mainActor->data[0].xViewport += 6;
                mainActor->data[0].xBackground += 6;

                mainActor->data[1].xViewport += 6;
                mainActor->data[1].xBackground += 6;
            }
            break;
    }

    setActTile = cmdGenSetActTile(0, true, mainActor->data[0].tile, false, mainActor->data[0].flipX, false, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(0, true, mainActor->data[0].xViewport, mainActor->data[0].yViewport, false, mainActor->data[0].flipX, false, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
    setActTile = cmdGenSetActTile(1, true, mainActor->data[1].tile, false, mainActor->data[1].flipX, false, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(1, true, mainActor->data[1].xViewport, mainActor->data[1].yViewport, false, mainActor->data[1].flipX, false, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
}
