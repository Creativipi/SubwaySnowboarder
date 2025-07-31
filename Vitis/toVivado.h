#ifndef _TOVIVADO_H_
#define _TOVIVADO_H_
 
#include <stdbool.h>
 
int cmdGenMoveView(int x, int y);
int cmdGenSetView(int x, int y);
int cmdGenMoveActPos(int act_id, bool ch_pos, int x, int y, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY);
int cmdGenSetActPos(int act_id, bool ch_pos, int x, int y, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY);
int cmdGenSetActTile(int act_id, bool ch_tile, int tile_id, bool ch_flipX, bool flipX, bool ch_flipY, bool flipY);
int cmdGenSetBackTile(int tile_id, bool ch_tile, int x, int y, bool ch_flipY, bool flipY);
int cmdGenSetBackPixTile(int tile_id, int colorCode, int x, int y);
int cmdGenSetActPixTile(int tile_id, int colorCode, int x, int y);
int cmdGenChColorRGB(int color_id, int r, int g, int b);
 
#endif