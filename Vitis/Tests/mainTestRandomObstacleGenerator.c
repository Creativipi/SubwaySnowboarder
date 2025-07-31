#include <stdio.h>

#include "randomGenerator.h"

void printBinary(int n) {
    for (int i = 31; i >= 0; i--) {
        int bit = (n >> i) & 1;
        printf("%d", bit);

        // Optional: add space every 4 bits for readability
        if (i % 4 == 0) {
            printf(" ");
        }
    }
    printf("\n");
}

int main()
{
    srand(time(NULL));

    float difficulty = 0.0f;

    for (int time = 0; time <= 1000; time++) {
        // Increase difficulty over time
        difficulty = (float)time / 500.0f;
        
        int numLines;

        int obstacleMask = generateObstacleMask(difficulty, &numLines, 0);
        printf("Time %2d | Difficulty: %.4f | Obstacles: ", time, difficulty);
        printObstacleLines(obstacleMask, numLines);
    }

    return 0;
}