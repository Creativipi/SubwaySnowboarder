#ifndef _DYNAMICARRAYHAZARDS_H_
#define _DYNAMICARRAYHAZARDS_H_

#include <stdio.h>
#include <stdlib.h>

typedef enum
{
    Small_Tree,
    Big_Tree,
    Rock
} Type;

typedef struct
{
    int x; // top left corner
    int y; // top left corner
    int height;
    int width;
    Type hazard;
} Positions;

typedef struct {
    Positions* data;
    int size;
    int capacity;
} PositionArray;

void initArray(PositionArray* arr, int initialCapacity);
void resizeArray(PositionArray* arr, int newCapacity);
void push(PositionArray* arr, Positions pos);
void deleteAt(PositionArray* arr, int index);
void freeArray(PositionArray* arr);

#endif