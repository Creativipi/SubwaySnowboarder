#ifndef _RANDOMOBSTACLEGNERATOR_H_
#define _RANDOMOBSTACLEGNERATOR_H_

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int generateObstacleMask(float difficulty, int *numLines);
void printObstacleLines(int mask, int numLines);

#endif