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
        UINT8 hookSpriteFish;
        UINT8 spriteTile;
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
        // prepare Fish
        fish1.sprites[0] = 1;
        fish1.sprites[1] = 2;
        set_sprite_data(1, 2, FISH);
        set_sprite_tile(fish1.sprites[0], 1);
        set_sprite_tile(fish1.sprites[1], 2);
        // prepare hook
        fishingRod.yHook = 100;
        fishingRod.hookSprite = 3;
        fishingRod.hookSpriteFish = 4;
        fishingRod.spriteTile = 3;
        set_sprite_data(3, 4, ROD);
        set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
        set_sprite_data(5, 5, CAN);
        set_sprite_tile(5, 5);
        // configure graphics
        DISPLAY_ON;
        SHOW_SPRITES;
}

UINT8 randomRange(UINT8 start, UINT8 end) {
        return start + ((UINT8)rand()) % (end - start + (UINT8)1);
}

char collideWith() {
        /*
           returns char that contains what type of collider the hook collided with
           "" => nothing
           "o" => obsticle
           "f" => fish
         */
        return '';
}

void onCatchFish(){
        set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
}

void storeFish(){
        // only do this if a fish is on the hook
        if(fishingRod.spriteTile == fishingRod.hookSpriteFish) {
                set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
        }
}

void handleInput(){
        switch(joypad()) {

        case J_A:
                if(fishingRod.yHook<=30) {
                        storeFish();
                }

        case J_UP:
                if(fishingRod.yHook > 20) {
                        fishingRod.yHook -= 1;
                        // remove part of line that's too long
                        color(WHITE, WHITE, SOLID);
                        line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 14);
                }
                break;

        case J_DOWN:
                if(fishingRod.yHook<152) {
                        fishingRod.yHook += 1;
                        color(BLACK, BLACK, SOLID);
                        line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 17);
                }
                break;
        }
}

void main() {
        init();
        // get seed for random number generator from user input
        printf(" \n\n\n\n\n\n\n\n    PRESS START!\n");
        waitpad(J_START);
        seed = LY_REG;
        seed |= (UINT16)DIV_REG << 8;
        initrand(seed);
        // clear text
        printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        // draw initial string line
        line(80, 0, 80, fishingRod.yHook - 16);
        // draw lines of ice surface
        color(LTGREY, LTGREY, SOLID);
        line(0, 20, 70, 20);
        line(90, 20, 159, 20);
        // init positions
        moveFishTo(&fish1, 40, 40);
        // game loop
        while(1) {
                wait_vbl_done();
                moveFishTo(&fish1, fish1.x + 1, fish1.y);
                handleInput();
                move_sprite(fishingRod.spriteTile, 84, fishingRod.yHook);
                move_sprite(5, i, 100); // can
                if(fish1.x > 160) {
                        fish1.y = randomRange(40, 150);
                        fish1.x = 0;
                }
        }
}
