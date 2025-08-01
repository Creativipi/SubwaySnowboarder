#ifndef _ACTORSMOVEMENTS_H_
#define _ACTORSMOVEMENTS_H_

#include "toVivado.h"
#include "dynamicArrayActors.h"
#include "sleep.h"
#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"

void initializeActors(ActorArray* mainActor);
void moveMainActor(int direction, int numTimes, bool triedTurningLeft, bool triedTurningRight, ActorArray* mainActor);
void generateSubway(int tileX, int tileY, Actor* subway, int disponibleSubway);
void deleteSubway(ActorArray* subways, int indexInSubways);
void subwayAnimation(ActorArray* subways, int counter);

#endif