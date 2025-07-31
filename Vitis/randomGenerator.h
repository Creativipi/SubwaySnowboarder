#ifndef _RANDOMGENERATOR_H_
#define _RANDOMGENERATOR_H_

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int generateObstacleMask(float difficulty, int *numLines, int mode);
void printObstacleLines(int mask, int numLines);
int generateSubwayMask(int numLines);

#endif