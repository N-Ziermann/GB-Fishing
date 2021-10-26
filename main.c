#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdint.h>
#include <stdio.h>
#include <rand.h>
#include "fish.c"
#include "rod.c"
#include "can.c"
#include "numbers.c"

struct fish {
        UINT8 x;
        UINT8 y;
        UINT8 sprites[2];
        UINT8 index;
};

struct can {
        UINT8 x;
        UINT8 y;
        UINT8 sprite;
        UINT8 moveEveryXFrames;
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
typedef enum { false, true } bool;

UINT16 framecounter = 0;
UINT8 score = 0;
const UINT8 scoreLowerDigit = 10;
const UINT8 scoreHigherDigit = 11;
const UINT8 hookX = 84;
#define numFish 1
#define numCans 3
Fish fishArr[numFish];
Can canArr[numCans];
Rod fishingRod;
INT8 caughtFishIndex = -1;

UINT16 seed;
const UINT8 spriteSize = 8;


UINT8 randomRange(UINT8 start, UINT8 end) {
        return start + ((UINT8)rand()) % (end - start + (UINT8)1);
}

void moveFishTo(Fish *f, UINT8 x, UINT8 y) {
        if(f->index == caughtFishIndex) {
                f->x = 0;
                f->y = randomRange(40, 150);
        } else {
                f->x = x;
                f->y = y;
                if(f->x > 160) {
                        f->y = randomRange(40, 150);
                        f->x = 0;
                }
        }
        move_sprite(f->sprites[0], f->x, f->y);
        move_sprite(f->sprites[1], f->x - spriteSize, f->y);
}

void moveCanTo(Can *c, UINT8 x, UINT8 y) {
        if(framecounter % c->moveEveryXFrames == 0) {
                c->x = x;
                c->y = y;
                if(c->x > 160) {
                        c->y = randomRange(40, 150);
                        c->x = 0;
                }
                move_sprite(c->sprite, c->x, c->y);
        }
}

void init() {
        // prepare Fish
        fishArr[0].sprites[0] = 1;
        fishArr[0].sprites[1] = 2;
        fishArr[0].index = 0;
        set_sprite_data(1, 2, FISH);
        set_sprite_tile(fishArr[0].sprites[0], 1);
        set_sprite_tile(fishArr[0].sprites[1], 2);
        // prepare hook
        fishingRod.yHook = 20;
        fishingRod.hookSprite = 3;
        fishingRod.hookSpriteFish = 4;
        fishingRod.spriteTile = 3;
        set_sprite_data(3, 4, ROD);
        set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
        // prepare cans
        set_sprite_data(5, 5, CAN);
        canArr[0].sprite = 5;
        canArr[0].x = 50;
        canArr[0].y = 125;
        canArr[0].moveEveryXFrames = 1;
        set_sprite_tile(canArr[0].sprite, 5);
        canArr[1].sprite = 7;
        canArr[1].x = 90;
        canArr[1].y = 145;
        canArr[1].moveEveryXFrames = 2;
        set_sprite_tile(canArr[1].sprite, 5);
        canArr[2].sprite = 8;
        canArr[2].x = 70;
        canArr[2].y = 105;
        canArr[2].moveEveryXFrames = 3;
        set_sprite_tile(canArr[2].sprite, 5);
        // prepare NUMBERS
        set_sprite_data(6, 15, NUMBERS);
        set_sprite_tile(scoreLowerDigit, 6);
        set_sprite_tile(scoreHigherDigit, 6);
        // configure graphics
        DISPLAY_ON;
        SHOW_SPRITES;
}

bool doesCollide(UINT8 x1, UINT8 y1, UINT8 x2, UINT8 y2) {
        if (x1 < x2 + spriteSize &&
            x1 + spriteSize > x2 &&
            y1 < y2 + spriteSize &&
            y1 + spriteSize > y2) {
                return true;
        }
        return false;
}


void onCatchFish(){
        set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
}

void storeFish(){
        // only do this if a fish is on the hook
        if(caughtFishIndex != -1) {
                set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
                caughtFishIndex = -1;
                score++;
        }
}

void collideWith() {
        // hookX + 1 because the hook doesnt start at the edge of the sprite
        for(UINT8 i = 0; i < numFish; i++) {
                if( doesCollide(hookX + 1, fishingRod.yHook, fishArr[i].x, fishArr[i].y) ) {
                        onCatchFish();
                        caughtFishIndex = i;
                }
        }
        for(UINT8 i=0; i < numCans; i++) {
                if(canArr[i].x != NULL) {
                        if( doesCollide(hookX + 1, fishingRod.yHook, canArr[i].x, canArr[i].y) ) {
                                color(BLACK,WHITE,SOLID);
                                gotogxy(5,8);
                                gprintf("GAME OVER!");
                                waitpad(J_START);
                                reset();
                        }
                }
        }
}

void handleInput(){
        switch(joypad()) {

        case J_A:
                if(fishingRod.yHook<=30) {
                        storeFish();
                }
                break;

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
        moveFishTo(&fishArr[0], 40, 40);
        // game loop
        while(1) {
                framecounter++;
                UINT8 joydata = joypad();
                handleInput();
                moveFishTo(&fishArr[0], fishArr[0].x + 2, fishArr[0].y);
                move_sprite(fishingRod.spriteTile, hookX, fishingRod.yHook);

                for(UINT8 i =0; i<numCans; i++) {
                        moveCanTo(&canArr[i], canArr[i].x + 2, canArr[i].y);
                }

                set_sprite_tile(scoreLowerDigit, 6 + (score % 10));
                set_sprite_tile(scoreHigherDigit, 6 + (score / 10));
                move_sprite(scoreLowerDigit, 159, 20);
                move_sprite(scoreHigherDigit, 150, 20);
                collideWith();
                wait_vbl_done();
        }
}
