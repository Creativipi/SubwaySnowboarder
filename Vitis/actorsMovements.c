#include "actorsMovements.h"

const int VIEWPORT_WIDTH = 640; // Width of the viewport in pixels
const int VIEWPORT_HEIGHT = 360; // Height of the viewport in pixels

void initializeActors(ActorArray* mainActor) {
    Actor actor1;
    Actor actor0;
    int setActTile;
    int setActPos;

    actor1.actorIndex = 1;
    actor1.tile = 2;
    actor1.flipX = false;
    actor1.flipY = false;
    actor1.xViewport = (VIEWPORT_WIDTH / 2 - 7) - 1; // Centered in the viewport
    actor1.yViewport = (VIEWPORT_HEIGHT * (4.0 / 5.0) - 16) - 1;
    actor1.xBackground = actor1.xViewport + 4;
    actor1.yBackground = actor1.yViewport - 1;
    setActTile = cmdGenSetActTile(actor1.actorIndex, true, actor1.tile, true, actor1.flipX, true, actor1.flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(actor1.actorIndex, true, actor1.xViewport, actor1.yViewport, true, actor1.flipX, true, actor1.flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);

    actor0.actorIndex = 0;
    actor0.tile = 3;
    actor0.flipX = false;
    actor0.flipY = false;
    actor0.xViewport = (VIEWPORT_WIDTH / 2 - 7) - 1; // Centered in the viewport
    actor0.yViewport = (VIEWPORT_HEIGHT * (4.0 / 5.0)) - 1;
    actor0.xBackground = actor0.xViewport + 4;
    actor0.yBackground = actor0.yViewport - 1;
    setActTile = cmdGenSetActTile(actor0.actorIndex, true, actor0.tile, true, actor0.flipX, true, actor0.flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(actor0.actorIndex, true, actor0.xViewport, actor0.yViewport, true, actor0.flipX, true, actor0.flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);

    pushActor(mainActor, actor1); // Add the first actor to the array
    pushActor(mainActor, actor0); // Add the second actor to the array

    for (int i = 2; i < 8; i++) {
        setActTile = cmdGenSetActTile(i, true, 8, false, false, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    }
}

void moveMainActor(int direction, int numTimes, bool triedTurning, ActorArray* mainActor) {
    int setActTile;
    int setActPos;

    switch (direction) {
        case 0: // Left
            if (numTimes == 0) {
                mainActor->data[0].tile = 1;
                mainActor->data[0].flipX = true;
                mainActor->data[0].xViewport -= 9;
                mainActor->data[0].yViewport += 7;
                mainActor->data[0].xBackground -= 9;
                mainActor->data[0].yBackground += 7;

                mainActor->data[1].tile = 0;
                mainActor->data[1].flipX = true;
            } else if (numTimes == 25) {
                mainActor->data[0].tile = 2;
                mainActor->data[0].flipX = false;
                mainActor->data[0].xViewport += 9;
                mainActor->data[0].yViewport -= 7;
                mainActor->data[0].xBackground += 9;
                mainActor->data[0].yBackground -= 7;

                mainActor->data[1].tile = 3;
                mainActor->data[1].flipX = false;
            } else {
                mainActor->data[0].xViewport -= 2;
                mainActor->data[0].xBackground -= 2;

                mainActor->data[1].xViewport -= 2;
                mainActor->data[1].xBackground -= 2;
            }
            break;
        case 1: // Straight
            if (triedTurning) {
                if (numTimes % 8 == 0) {
                    if (numTimes == 0) {
                        mainActor->data[0].tile = 1;
                        mainActor->data[0].flipX = true;
                        mainActor->data[0].xViewport -= 9;
                        mainActor->data[0].yViewport += 7;
                        mainActor->data[0].xBackground -= 9;
                        mainActor->data[0].yBackground += 7;

                        mainActor->data[1].tile = 0;
                        mainActor->data[1].flipX = true;
                    } else if (numTimes == 8) {
                        mainActor->data[0].flipX = false;
                        mainActor->data[0].xViewport += 18;
                        mainActor->data[0].xBackground += 18;

                        mainActor->data[1].flipX = false;
                    } else if (numTimes == 16) {
                        mainActor->data[0].flipX = true;
                        mainActor->data[0].xViewport -= 18;
                        mainActor->data[0].xBackground -= 18;

                        mainActor->data[1].flipX = true;
                    }
                } else if (numTimes == 25) {
                    mainActor->data[0].tile = 2;
                    mainActor->data[0].flipX = false;
                    mainActor->data[0].xViewport += 9;
                    mainActor->data[0].yViewport -= 7;
                    mainActor->data[0].xBackground += 9;
                    mainActor->data[0].yBackground -= 7;

                    mainActor->data[1].tile = 3;
                    mainActor->data[1].flipX = false;
                }
            }
            break;
        case 2:  // Right
            if (numTimes == 0) {
                mainActor->data[0].tile = 1;
                mainActor->data[0].xViewport += 9;
                mainActor->data[0].yViewport += 7;
                mainActor->data[0].xBackground += 9;
                mainActor->data[0].yBackground += 7;

                mainActor->data[1].tile = 0;
            } else if (numTimes == 25) {
                mainActor->data[0].tile = 2;
                mainActor->data[0].xViewport -= 9;
                mainActor->data[0].yViewport -= 7;
                mainActor->data[0].xBackground -= 9;
                mainActor->data[0].yBackground -= 7;

                mainActor->data[1].tile = 3;
            } else {
                mainActor->data[0].xViewport += 2;
                mainActor->data[0].xBackground += 2;

                mainActor->data[1].xViewport += 2;
                mainActor->data[1].xBackground += 2;
            }
            break;
    }

    setActTile = cmdGenSetActTile(mainActor->data[0].actorIndex, true, mainActor->data[0].tile, true, mainActor->data[0].flipX, true, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(mainActor->data[0].actorIndex, true, mainActor->data[0].xViewport, mainActor->data[0].yViewport, false, mainActor->data[0].flipX, false, mainActor->data[0].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
    setActTile = cmdGenSetActTile(mainActor->data[1].actorIndex, true, mainActor->data[1].tile, true, mainActor->data[1].flipX, true, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(mainActor->data[1].actorIndex, true, mainActor->data[1].xViewport, mainActor->data[1].yViewport, false, mainActor->data[1].flipX, false, mainActor->data[1].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
}

void generateSubway(int tileX, int tileY, Actor* subway, int disponibleSubway) {
    int setActTile;
    int setActPos;

    subway->actorIndex = disponibleSubway;
    subway->tile = 4;
    subway->flipX = false;
    subway->flipY = false;
    subway->xViewport = ((tileX * 8) - 4) + 28;
    subway->yViewport = -192 - 8;
    subway->xBackground = tileX * 8 + 28;
    subway->yBackground = tileY * 8 - 8;
    setActTile = cmdGenSetActTile(subway->actorIndex, true, subway->tile, true, subway->flipX, true, subway->flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(subway->actorIndex, true, subway->xViewport, subway->yViewport, true, subway->flipX, true, subway->flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
}

void deleteSubway(ActorArray* subways, int indexInSubways) {
    int setActTile;
    int setActPos;

    // Shift the remaining subways
    for (int i = indexInSubways; i < subways->size - 1; i++) {
        subways->data[i].tile = subways->data[i + 1].tile;
        subways->data[i].flipX = subways->data[i + 1].flipX;
        subways->data[i].flipY = subways->data[i + 1].flipY;
        subways->data[i].xViewport = subways->data[i + 1].xViewport;
        subways->data[i].yViewport = subways->data[i + 1].yViewport;
        subways->data[i].xBackground = subways->data[i + 1].xBackground;
        subways->data[i].yBackground = subways->data[i + 1].yBackground;

        setActTile = cmdGenSetActTile(subways->data[i].actorIndex, true, subways->data[i].tile, true, subways->data[i].flipX, true, subways->data[i].flipY);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    }

    // Set the subway tile to empty
    setActTile = cmdGenSetActTile(subways->data[subways->size - 1].actorIndex, true, 8, false, false, false, false);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    setActPos = cmdGenSetActPos(subways->data[subways->size - 1].actorIndex, true, 0, 0, false, false, false, false);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);

    // Remove the subway from the array
    deleteActorAt(subways, subways->size - 1);
}