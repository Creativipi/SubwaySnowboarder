#ifndef _DYNAMICARRAYHAZARDS_H_
#define _DYNAMICARRAYHAZARDS_H_

#include <stdio.h>
#include <stdlib.h>

typedef enum {
    Mini_Tree,
    Big_Tree,
    Fat_Rock,
    Mini_Rock,
    Square_Rock,
    Mega_Rock
} HazardType;

typedef struct {
    int x; // top left corner
    int y; // top left corner
    int tileX;
	int rmvTileY;
    HazardType hazardType;
} Positions;

typedef struct {
    Positions* data;
    int size;
    int capacity;
} PositionArray;

typedef struct {
    int height;
    int width;
} Dimensions;

static const Dimensions hazardDimensions[] = {
    [Mini_Tree]   = {8, 8},
    [Big_Tree]    = {24, 16},
    [Fat_Rock]    = {8, 24},
    [Mini_Rock]   = {8, 16},
    [Square_Rock] = {16, 16},
    [Mega_Rock]   = {16, 24}
};

Dimensions getHazardDimensions(HazardType hazard);
void initArray(PositionArray* arr, int initialCapacity);
void resizeArray(PositionArray* arr, int newCapacity);
void pushHazard(PositionArray* arr, Positions pos);
void deleteAt(PositionArray* arr, int index);
void freeArray(PositionArray* arr);

#endif