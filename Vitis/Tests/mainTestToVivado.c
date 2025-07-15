#include <stdio.h>

#include "toVivado.h"

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
    int a = cmdGenMoveView(1, 1);
    int b = cmdGenMoveView(2, 2);
    int c = cmdGenMoveView(3, 3);
    int d = cmdGenMoveView(4, 4);
    int e = cmdGenMoveView(5, 5);
    int f = cmdGenMoveView(16777215, 16777215);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenSetView(1, 1);
    b = cmdGenSetView(2, 2);
    c = cmdGenSetView(3, 3);
    d = cmdGenSetView(4, 4);
    e = cmdGenSetView(5, 5);
    f = cmdGenSetView(16777215, 16777215);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenMoveActPos(1, false, 1, 1, false, false, false, false);
    b = cmdGenMoveActPos(2, true, 2, 2, true, true, true, true);
    c = cmdGenMoveActPos(3, false, 3, 3, false, false, false, false);
    d = cmdGenMoveActPos(4, true, 4, 4, true, true, true, true);
    e = cmdGenMoveActPos(5, false, 50, 50, false, false, false, false);
    f = cmdGenMoveActPos(16777215, true, 16777215, 16777215, true, true, true, true);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenSetActPos(1, false, 1, 1, false, false, false, false);
    b = cmdGenSetActPos(2, true, 2, 2, true, true, true, true);
    c = cmdGenSetActPos(3, false, 3, 3, false, false, false, false);
    d = cmdGenSetActPos(4, true, 4, 4, true, true, true, true);
    e = cmdGenSetActPos(5, false, 50, 50, false, false, false, false);
    f = cmdGenSetActPos(16777215, true, 16777215, 16777215, true, true, true, true);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenSetActTile(1, false, 1, false, false, false, false);
    b = cmdGenSetActTile(2, true, 2, true, true, true, true);
    c = cmdGenSetActTile(3, false, 3, false, false, false, false);
    d = cmdGenSetActTile(4, true, 4, true, true, true, true);
    e = cmdGenSetActTile(5, false, 15, false, false, false, false);
    f = cmdGenSetActTile(16777215, true, 16777215, true, true, true, true);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenSetBackTile(1, false, 1, 1, false, false);
    b = cmdGenSetBackTile(2, true, 2, 2, true, true);
    c = cmdGenSetBackTile(3, false, 3, 3, false, false);
    d = cmdGenSetBackTile(4, true, 4, 4, true, true);
    e = cmdGenSetBackTile(15, false, 15, 15, false, false);
    f = cmdGenSetBackTile(16777215, true, 16777215, 16777215, true, true);
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    printf("\n");

    a = cmdGenChColorRGB(0, 255, 0, 0); // Color ID 0, Red
    b = cmdGenChColorRGB(1, 0, 255, 0); // Color ID 1, Green
    c = cmdGenChColorRGB(2, 0, 0, 255); // Color ID 2, Blue
    d = cmdGenChColorRGB(3, 255, 255, 0); // Color ID 3, Yellow
    e = cmdGenChColorRGB(4, 255, 0, 255); // Color ID 4, Magenta
    f = cmdGenChColorRGB(16777215, 16777215, 16777215, 16777215); // Invalid color ID, should be masked
    printBinary(a);
    printBinary(b);
    printBinary(c);
    printBinary(d);
    printBinary(e);
    printBinary(f);

    return 0;
}