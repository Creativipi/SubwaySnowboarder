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

void initArray(PositionArray* arr, int initialCapacity) {
    arr->data = malloc(initialCapacity * sizeof(Positions));
    arr->size = 0;
    arr->capacity = initialCapacity;
}

void resizeArray(PositionArray* arr, int newCapacity){
    arr->data = realloc(arr->data, newCapacity * sizeof(Positions));
    arr->capacity = newCapacity;
}

void push(PositionArray* arr, Positions pos){
    if (arr -> size >= arr->capacity){
        resizeArray(arr, arr->capacity * 2);
    }
    arr->data[arr->size] = pos;
    arr->size++;
}

void deleteAt(PositionArray* arr, int index){
    if (index < 0 || index >= arr->size) {
        printf("Index is invalid");
        return;
    }
    for (int i = index; i < arr->size - 1; i++) {
        arr->data[i] = arr->data[i + 1];
    }
    arr->size--;
}

void freeArray(PositionArray* arr){
    free(arr->data);
}