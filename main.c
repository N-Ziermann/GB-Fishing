#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdint.h>
#include <stdio.h>
#include <rand.h>
#include "fish.c"
#include "rod.c"
#include "can.c"

struct fish {
        UINT8 x;
        UINT8 y;
        UINT8 sprites[2];
};

struct can {
        UINT8 x;
        UINT8 y;
        UINT8 sprite;
};

struct rod {
        UINT8 yHook;
        UINT8 hookSprite;
};

typedef struct fish Fish;
typedef struct rod Rod;
typedef struct can Can;

Fish fish1;
Rod fishingRod;
UINT8 i = 0;
UINT16 seed;
const UINT8 spriteSize = 8;

void moveFishTo(Fish *f, UINT8 x, UINT8 y) {
        f->x = x;
        f->y = y;
        move_sprite(f->sprites[0], x, y);
        move_sprite(f->sprites[1], x-spriteSize, y);
}

void init() {
        fish1.sprites[0] = 1;
        fish1.sprites[1] = 2;
        moveFishTo(&fish1, 20, 30);
        set_sprite_data(1, 2, FISH);
        set_sprite_tile(fish1.sprites[0], 1);
        set_sprite_tile(fish1.sprites[1], 2);
        fishingRod.yHook = 100;
        fishingRod.hookSprite = 3;
        set_sprite_data(3, 3, ROD);
        set_sprite_tile(fishingRod.hookSprite, 3);
        set_sprite_data(4, 4, CAN);
        set_sprite_tile(4, 4);
        DISPLAY_ON;
        SHOW_SPRITES;
}

UINT8 randomRange(UINT8 start, UINT8 end) {
        return start + ((UINT8)rand()) % (end - start + (UINT8)1);
}

void main() {
        init();
        // get seed for random number generator from user input
        printf("PRESS START!");
        waitpad(J_START);
        seed = LY_REG;
        seed |= (UINT16)DIV_REG << 8;
        initrand(seed);
        // clear text
        printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        // draw initial string line
        line(80, 0, 80, fishingRod.yHook - 16);
        // game loop
        while(1) {
                wait_vbl_done();
                moveFishTo(&fish1, fish1.x + 1, fish1.y);
                switch(joypad()) {
                case J_UP:
                        if(fishingRod.yHook > 20) {
                                fishingRod.yHook -= 1;
                                // remove part of line that's too long
                                color(WHITE, WHITE, SOLID);
                                line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 14);
                                color(BLACK, BLACK, SOLID);
                        }
                        break;
                case J_DOWN:
                        if(fishingRod.yHook<152) {
                                fishingRod.yHook += 1;
                                line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 17);
                        }
                        break;
                }
                move_sprite(fishingRod.hookSprite, 84,fishingRod.yHook);
                move_sprite(4, 100, 100);
        }
}
