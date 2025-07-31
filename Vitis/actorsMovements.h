#ifndef _ACTORSMOVEMENTS_H_
#define _ACTORSMOVEMENTS_H_

#include "toVivado.h"
#include "dynamicArrayActors.h"
#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"

void initializeActors(ActorArray* mainActor);
void moveMainActor(int direction, int numTimes, bool triedTurning, ActorArray* mainActor);
void generateSubway(int tileX, int tileY, Actor* subway, int disponibleSubway);
void deleteSubway(ActorArray* subways, int actorIndex, int indexInSubways);

#endif