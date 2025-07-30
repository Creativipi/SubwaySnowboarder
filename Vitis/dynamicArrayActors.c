#include "dynamicArrayActors.h"

void initActorArray(ActorArray* arr, int initialCapacity) {
    arr->data = malloc(initialCapacity * sizeof(Actor));
    arr->size = 0;
    arr->capacity = initialCapacity;
}

void pushActor(ActorArray* arr, Actor actor) {
    if (arr->size >= arr->capacity) {
        arr->capacity *= 2; // Double the capacity
        arr->data = realloc(arr->data, arr->capacity * sizeof(Actor));
    }
    arr->data[arr->size] = actor;
    arr->size++;
}

void deleteActorAt(ActorArray* arr, int index) {
    if (index < 0 || index >= arr->size) {
        printf("Index is invalid\n");
        return;
    }
    for (int i = index; i < arr->size - 1; i++) {
        arr->data[i] = arr->data[i + 1];
    }
    arr->size--;
}

void freeActorArray(ActorArray* arr) {
    free(arr->data);
    arr->data = NULL; // Avoid dangling pointer
    arr->size = 0;
    arr->capacity = 0;
}