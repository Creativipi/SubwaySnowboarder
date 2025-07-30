#ifndef _HAZARD_GENERATION_H_
#define _HAZARD_GENERATION_H_

#include <stdbool.h>

#include "dynamicArrayHazards.h"
#include "toVivado.h"
#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"

void generateObstacle(int tileX, int tileY, Positions* obstacleHitZone);
void deleteObstacle(int tileX, int tileY);

#endif