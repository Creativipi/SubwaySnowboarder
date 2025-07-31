#include "randomGenerator.h"

int generateObstacleMask(float difficulty, int *numLines, int mode) {
    if (mode < 0 || mode > 1) {
        printf("Invalid mode. Use 0 for a growing number of lines, or 1 for a fixed 5-line display.\n");
        return -1; // Error code
    }

    int numBitsPossibilityRange;
    int numBitsToSet;

    if (mode == 0) {
        int values[] = {3, 5, 7, 9, 11, 13};
        int numValues = sizeof(values) / sizeof(values[0]);
        int index = (int)(difficulty * (numValues - 1) + 0.5f);
        if (index > 5) index = 5; // Cap index to the maximum value
        *numLines = values[index];

        /*
        * Difficulty range to *numLines mapping (rounded index):
        * difficulty ∈ [0.000, 0.099)   → index = 0 → *numLines = 3
        * difficulty ∈ [0.100, 0.299)   → index = 1 → *numLines = 5
        * difficulty ∈ [0.300, 0.499)   → index = 2 → *numLines = 7
        * difficulty ∈ [0.500, 0.699)   → index = 3 → *numLines = 9
        * difficulty ∈ [0.700, 0.899)   → index = 4 → *numLines = 11
        * difficulty ∈ [0.900, 1.000)   → index = 5 → *numLines = 13
        */

        numBitsPossibilityRange = 4;
        numBitsToSet = rand() % numBitsPossibilityRange; // From 0 to 3 bits
        switch (*numLines) {
        case 3:
            if (difficulty < 0.05f) {
                numBitsPossibilityRange = 2; // From 0 to 1 bits of 3
            } else {
                numBitsPossibilityRange = 3; // From 0 to 2 bits of 3
            }
            numBitsToSet = rand() % numBitsPossibilityRange;
            break;
        case 5:
            if (difficulty > 0.2f) {
                numBitsToSet++; // From 1 to 4 bits of 5
            }
            break;
        case 7:
            if (difficulty < 0.4f) {
                numBitsToSet += 2; // From 2 to 5 bits of 7
            } else {
                numBitsToSet += 3; // From 3 to 6 bits of 7
            }
            break;
        case 9:
            if (difficulty < 0.6f) {
                numBitsToSet += 4; // From 4 to 7 bits of 9
            } else {
                numBitsToSet += 5; // From 5 to 8 bits of 9
            }
            break;
        case 11:
            if (difficulty < 0.8f) {
                numBitsToSet += 6; // From 6 to 9 bits of 11
            } else {
                numBitsToSet += 7; // From 7 to 10 bits of 11
            }
            break;
        case 13:
            if (difficulty < 0.95f) {
                numBitsToSet += 8; // From 8 to 11 bits of 13
            } else if (difficulty < 1.10f) {
                numBitsToSet += 9; // From 9 to 12 bits of 13
            } else if (difficulty < 1.35f) {
                numBitsPossibilityRange = 3;
                numBitsToSet = rand() % numBitsPossibilityRange;
                numBitsToSet += 10; // From 10 to 12 bits of 13
            } else if (difficulty < 1.50f) {
                numBitsPossibilityRange = 2;
                numBitsToSet = rand() % numBitsPossibilityRange;
                numBitsToSet += 11; // From 11 to 12 bits of 13
            } else {
                numBitsToSet = 12; // 12 bits of 13
            }
            break;
        }
    } else if (mode == 1) {
        *numLines = 5; // Fixed number of lines for mode 1

        numBitsPossibilityRange = 2;
        numBitsToSet = rand() % numBitsPossibilityRange;
        numBitsToSet++; // From 1 to 2 bits of 5
        if (difficulty > 0.3f && difficulty < 0.5f) {
            numBitsToSet += 2; // From 2 to 3 bits of 5
        } else if (difficulty > 0.5f && difficulty < 0.8f) {
            numBitsToSet += 3; // From 3 to 4 bits of 5
        } else if (difficulty > 0.8f) {
            numBitsToSet = 4; // 4 bits of 5
        }
    }
    
    
    int mask = 0;
    while (numBitsToSet > 0) {
        int bit = rand() % *numLines;
        if (!(mask & (1 << bit))) {
            mask |= (1 << bit);
            numBitsToSet--;
        }
    }

    return mask;
}

void printObstacleLines(int mask, int numLines) {
    int counter = 0;
    for (int i = numLines - 1; i >= 0; i--) {
        if (mask & (1 << i)) {
            printf("1");
            counter++;
        } else {
            printf("0");
        }
    }
    printf(" (0x%X) %i/%i\n", mask, counter, numLines);
}

int generateSubwayMask(int numLines) {
    int mask = 0;
    int numBitsToSet = (rand() % 5) - 3;
    
    if (numBitsToSet < 0) {
        numBitsToSet = 0;
    }

    while (numBitsToSet > 0) {
        int bit = rand() % numLines;
        if (!(mask & (1 << bit))) {
            mask |= (1 << bit);
            numBitsToSet--;
        }
    }

    return mask;
}