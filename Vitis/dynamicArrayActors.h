#ifndef _DYNAMICARRAYACTORS_H_
#define _DYNAMICARRAYACTORS_H_

#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int x;
    int y;
    int tile;
} Actor;

typedef struct {
    Actor* data;
    int size;
    int capacity;
} ActorArray;

void initActorArray(ActorArray* arr, int initialCapacity);
void pushActor(ActorArray* arr, Actor actor);
void deleteActorAt(ActorArray* arr, int index);
void freeActorArray(ActorArray* arr);

#endif