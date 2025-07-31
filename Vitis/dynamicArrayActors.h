#ifndef _DYNAMICARRAYACTORS_H_
#define _DYNAMICARRAYACTORS_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct {
    int actorIndex;
    int tile;
    bool flipX; // Flip horizontally
    bool flipY; // Flip vertically
    int xViewport; // Viewport X position
    int yViewport; // Viewport Y position
    int xBackground; // Background X position
    int yBackground; // Background Y position
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