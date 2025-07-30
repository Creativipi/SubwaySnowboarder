#include "toVivado.h"

#define MASK_N_BITS(value, n) ((value) & ((1U << (n)) - 1))

int cmdGenMoveView(int x, int y) {
    int opcode = 0x0;
    x = MASK_N_BITS(x, 10); // Ensure x is within 10 bits
    y = MASK_N_BITS(y, 10); // Ensure y is within 10 bits
    return (opcode << 28) | (x << 14) | (y << 4);
}

int cmdGenSetView(int x, int y) {
    int opcode = 0x1;
    x = MASK_N_BITS(x, 10); // Ensure x is within 10 bits
    y = MASK_N_BITS(y, 10); // Ensure y is within 10 bits
    return (opcode << 28) | (x << 14) | (y << 4);
}

int cmdGenMoveActPos(int act_id, bool ch_pos, int x, int y, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY) {
    int opcode = 0x2;
    act_id = MASK_N_BITS(act_id, 3); // Ensure act_id is within 3 bits
    x = MASK_N_BITS(x, 10); // Ensure x is within 10 bits
    y = MASK_N_BITS(y, 10); // Ensure y is within 10 bits
    return (opcode << 28) | (act_id << 25) | (ch_pos << 24) | (x << 14) | (y << 4) | (ch_flipX << 3) | (flipX << 2) | (ch_flipY << 1) | (flipY << 0);
}

int cmdGenSetActPos(int act_id, bool ch_pos, int x, int y, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY) {
    int opcode = 0x3;
    act_id = MASK_N_BITS(act_id, 3); // Ensure act_id is within 3 bits
    x = MASK_N_BITS(x, 10); // Ensure x is within 10 bits
    y = MASK_N_BITS(y, 10); // Ensure y is within 10 bits
    return (opcode << 28) | (act_id << 25) | (ch_pos << 24) | (x << 14) | (y << 4) | (ch_flipX << 3) | (flipX << 2) | (ch_flipY << 1) | (flipY << 0);
}

int cmdGenSetActTile(int act_id, bool ch_tile, int tile_id, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY) {
    int opcode = 0x4;
    act_id = MASK_N_BITS(act_id, 3); // Ensure act_id is within 3 bits
    tile_id = MASK_N_BITS(tile_id, 4); // Ensure tile_id is within 4 bits
    return (opcode << 28) | (act_id << 25) | (ch_tile << 24) | (tile_id << 21) | (ch_flipX << 3) | (flipX << 2) | (ch_flipY << 1) | (flipY << 0);
}

int cmdGenSetBackTile(int tile_id, bool ch_tile, int x, int y, bool ch_flipY, bool flipY) {
    int opcode = 0x5;
    tile_id = MASK_N_BITS(tile_id, 5); // Ensure tile_id is within 5 bits
    x = MASK_N_BITS(x, 7); // Ensure x is within 7 bits
    y = MASK_N_BITS(y, 7); // Ensure y is within 7 bits
    return (opcode << 28) | (tile_id << 23) | (ch_tile << 22) | (x << 15) | (y << 8) | (ch_flipY << 1) | (flipY << 0);
}

int cmdGenChColorRGB(int color_id, int r, int g, int b) {
    int opcode = 0xF;
    color_id = MASK_N_BITS(color_id, 4); // Ensure color_id is within 4 bits
    r = MASK_N_BITS(r, 8); // Ensure r is within 8 bits
    g = MASK_N_BITS(g, 8); // Ensure g is within 8 bits
    b = MASK_N_BITS(b, 8); // Ensure b is within 8 bits
    return (opcode << 28) | (color_id << 24) | (r << 16) | (b << 8) | (g << 0); // Switch from RGB to RBG
}