#include "actorsMovements.h"

const int VIEWPORT_WIDTH = 640; // Width of the viewport in pixels
const int VIEWPORT_HEIGHT = 360; // Height of the viewport in pixels

static void colorEvilFace(int row) {
    int setBackPixTile;

    switch (row) {
    case 0:
        for (int i = 0; i < 5; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 7);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        } 
        break;
    case 1:
        for (int i = 1; i < 5; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 6);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        } 
        break;
    case 2:
        for (int i = 2; i < 6; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 5);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        }
        break;
    case 3:
        for (int i = 2; i < 6; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 4);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        }
        break;
    case 4:
        for (int i = 3; i < 7; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 3);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        }
        break;
    case 5:
        for (int i = 4; i < 8; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 2);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        }
        break;
    case 6:
        for (int i = 5; i < 8; i++) {
            setBackPixTile = cmdGenSetBackPixTile(25, 4, i, 1);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackPixTile);
        }
        break;
    default:
        break;
    }
}

static void evilFace() {
	int setView;
	int setBackTile;
	int tileId;

	// black (24) and red (25)
	// Array of (x, y, tileId)
	const int pixelData[][3] = {
		// Format: {x, y, tileId}
		{3, 2, 24}, {4, 2, 24}, {10, 2, 24}, {11, 2, 24},
		{2, 3, 24}, {3, 3, 24}, {4, 3, 24}, {5, 3, 24},
		{9, 3, 24}, {10, 3, 24}, {11, 3, 24}, {12, 3, 24},
		{2, 4, 24}, {3, 4, 25}, {4, 4, 25}, {5, 4, 24},
		{9, 4, 24}, {10, 4, 25}, {11, 4, 25}, {12, 4, 24},
		{1, 5, 24}, {2, 5, 24}, {3, 5, 24}, {4, 5, 24}, {5, 5, 24},
		{9, 5, 24}, {10, 5, 24}, {11, 5, 24}, {12, 5, 24}, {13, 5, 24},
		{1, 8, 24}, {2, 9, 24}, {3, 10, 24}, {4, 11, 24}, {5, 12, 24}, {6, 12, 24},
		{7, 12, 24}, {8, 12, 24}, {9, 12, 24}, {10, 11, 24}, {11, 10, 24}, {12, 9, 24}, {13, 8, 24},
	};

	setView = cmdGenSetView(4, 0);
	MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setView);

	int numPixels = sizeof(pixelData) / sizeof(pixelData[0]);
	for (int i = 0; i < numPixels; ++i) {
		tileId = pixelData[i][2];
		int tileX = pixelData[i][0] - 1 + 34;
		int tileY = pixelData[i][1] - 2 + 10;
        if ((tileId == 25 && pixelData[i][0] == 4) || (tileId == 25 && pixelData[i][0] == 11)) {
            setBackTile = cmdGenSetBackTile(tileId, true, tileX, tileY, true, true);
        } else {
            setBackTile = cmdGenSetBackTile(tileId, true, tileX, tileY, false, false);
        }
		MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setBackTile);
	}
}

static void party() {
    int setActTile;
    int setActPos;

    ActorArray animSubways;
    Actor actor2;
    Actor actor3;
    Actor actor4;
    Actor actor5;
    Actor actor6;
    Actor actor7;
    initActorArray(&animSubways, 6);
    pushActor(&animSubways, actor2);
    pushActor(&animSubways, actor3);
    pushActor(&animSubways, actor4);
    pushActor(&animSubways, actor5);
    pushActor(&animSubways, actor6);
    pushActor(&animSubways, actor7);
    for (int i = 0; i < animSubways.size; i++) {
        int randomNum = (rand() % 4) + 4; // Random number between 4 and 7
        animSubways.data[i].actorIndex = i + 2; // Actor indices from 2 to 7
        animSubways.data[i].tile = randomNum;
        animSubways.data[i].flipX = false;
        animSubways.data[i].flipY = false; 
        animSubways.data[i].xViewport = (VIEWPORT_WIDTH / 2 - 7) - 1; // Centered in the viewport
        animSubways.data[i].yViewport = (VIEWPORT_HEIGHT / 2 - 7) - 1; // Centered in the viewport
        setActTile = cmdGenSetActTile(animSubways.data[i].actorIndex, true, animSubways.data[i].tile, false, false, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
        setActPos = cmdGenSetActPos(animSubways.data[i].actorIndex, true, animSubways.data[i].xViewport, animSubways.data[i].yViewport, false, false, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
    }

    evilFace();

    int counter = 0;
    int direction[6];
    int newX;
    int newY;
    while (counter < 1700) {
        if (counter % 120 == 0) {
            colorEvilFace(counter / 120);
        }

        for (int i = 0; i < animSubways.size; i++) {
            if (counter % 8 == 0) {
                subwayAnimation(&animSubways, i);
            }

            if (counter < 1300) {
                if (counter % 32 == 0) {
                    direction[i] = rand() % 8; // Random direction for each subway actor
                }
            } else {
                direction[i] = 0; // Exit
            }

            switch (direction[i]) {
            case 0: // Move up
                newX = animSubways.data[i].xViewport;
                newY = animSubways.data[i].yViewport - 1;
                break;
            case 1: // Move right and up
                newX = animSubways.data[i].xViewport + 1;
                newY = animSubways.data[i].yViewport - 1;
                break;
            case 2: // Move right
                newX = animSubways.data[i].xViewport + 1;
                newY = animSubways.data[i].yViewport;
                break;
            case 3: // Move right and down
                newX = animSubways.data[i].xViewport + 1;
                newY = animSubways.data[i].yViewport + 1;
                break;
            case 4: // Move down
                newX = animSubways.data[i].xViewport;
                newY = animSubways.data[i].yViewport + 1;
                break;
            case 5: // Move left and down
                newX = animSubways.data[i].xViewport - 1;
                newY = animSubways.data[i].yViewport + 1;
                break;
            case 6: // Move left
                newX = animSubways.data[i].xViewport - 1;
                newY = animSubways.data[i].yViewport;
                break;
            case 7: // Move left and up
                newX = animSubways.data[i].xViewport - 1;
                newY = animSubways.data[i].yViewport - 1;
                break;
            }

            if (counter < 1300) {
                if (newX < 0) newX = 1;
                if (newY < 0) newY = 1;
                if (newX > 623) newX = 622;
                if (newY > ((VIEWPORT_HEIGHT * (4.0 / 5.0) - 16) - 1) - 32) newY = (((VIEWPORT_HEIGHT * (4.0 / 5.0) - 16) - 1) - 32) - 1;
            }
            
            animSubways.data[i].xViewport = newX;
            animSubways.data[i].yViewport = newY;

            setActPos = cmdGenSetActPos(animSubways.data[i].actorIndex, true, animSubways.data[i].xViewport, animSubways.data[i].yViewport, false, false, false, false);
            MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActPos);
        }
        counter++;
        usleep(10000); // Sleep for 10 milliseconds to control the animation speed
    }
    freeActorArray(&animSubways); // Free the animSubways array
}

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

    party();

    for (int i = 2; i < 8; i++) {
        setActTile = cmdGenSetActTile(i, true, 8, false, false, false, false);
        MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
    }
}

void moveMainActor(int direction, int numTimes, bool triedTurningLeft, bool triedTurningRight, ActorArray* mainActor) {
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
            if (triedTurningLeft) {
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
                }
            }
            if (triedTurningRight) {
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

void subwayAnimation(ActorArray* subways, int counter) {
    int setActTile;

    subways->data[counter].tile += 1;
    if (subways->data[counter].tile > 7) {
        subways->data[counter].tile = 4;
    }
    if (subways->data[counter].tile == 7) {
        if (subways->data[counter].flipX) {
            subways->data[counter].flipX = false;
        } else {
            subways->data[counter].flipX = true;
        }
        if (subways->data[counter].flipY) {
            subways->data[counter].flipY = false;
        } else {
            subways->data[counter].flipY = true;
        }
    }

    setActTile = cmdGenSetActTile(subways->data[counter].actorIndex, true, subways->data[counter].tile, true, subways->data[counter].flipX, true, subways->data[counter].flipY);
    MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, setActTile);
}