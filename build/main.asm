;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12439 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _handleInput
	.globl _storeFish
	.globl _onCatchFish
	.globl _collideWith
	.globl _randomRange
	.globl _init
	.globl _moveFishTo
	.globl _rand
	.globl _initrand
	.globl _puts
	.globl _color
	.globl _line
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _waitpad
	.globl _joypad
	.globl _i
	.globl _seed
	.globl _fishingRod
	.globl _fish1
	.globl _spriteSize
	.globl _CAN
	.globl _ROD
	.globl _FISH
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_fish1::
	.ds 4
_fishingRod::
	.ds 4
_seed::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_i::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:39: void moveFishTo(Fish *f, UINT8 x, UINT8 y) {
;	---------------------------------
; Function moveFishTo
; ---------------------------------
_moveFishTo::
	dec	sp
	dec	sp
;main.c:40: f->x = x;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
;main.c:41: f->y = y;
	ld	a, (hl+)
	ld	(de), a
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:42: move_sprite(f->sprites[0], x, y);
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:43: move_sprite(f->sprites[1], x-spriteSize, y);
;setupPair	HL
	ld	hl, #_spriteSize
	ld	c, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, c
	ld	c, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:43: move_sprite(f->sprites[1], x-spriteSize, y);
;main.c:44: }
	inc	sp
	inc	sp
	ret
_FISH:
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x05	; 5
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x15	; 21
	.db #0x1d	; 29
	.db #0x22	; 34
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x1d	; 29
	.db #0x22	; 34
	.db #0x08	; 8
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x08	; 8
_ROD:
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
_CAN:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x10	; 16
	.db #0x2a	; 42
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x20	; 32
_spriteSize:
	.db #0x08	; 8
;main.c:46: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:48: fish1.sprites[0] = 1;
	ld	bc, #_fish1 + 2
	ld	a, #0x01
	ld	(bc), a
;main.c:49: fish1.sprites[1] = 2;
	ld	hl, #(_fish1 + 3)
	ld	(hl), #0x02
;main.c:50: set_sprite_data(1, 2, FISH);
	ld	de, #_FISH
	push	de
	ld	hl, #0x201
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:51: set_sprite_tile(fish1.sprites[0], 1);
	ld	a, (bc)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x01
;main.c:52: set_sprite_tile(fish1.sprites[1], 2);
	ld	hl, #(_fish1 + 3)
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x02
;main.c:54: fishingRod.yHook = 100;
	ld	hl, #_fishingRod
	ld	(hl), #0x64
;main.c:55: fishingRod.hookSprite = 3;
	ld	bc, #_fishingRod + 1
	ld	a, #0x03
	ld	(bc), a
;main.c:56: fishingRod.hookSpriteFish = 4;
	ld	hl, #(_fishingRod + 2)
	ld	(hl), #0x04
;main.c:57: fishingRod.spriteTile = 3;
	ld	hl, #(_fishingRod + 3)
	ld	(hl), #0x03
;main.c:58: set_sprite_data(3, 4, ROD);
	ld	de, #_ROD
	push	de
	ld	hl, #0x403
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:59: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
	ld	a, (bc)
	ld	c, a
	ld	hl, #(_fishingRod + 3)
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:60: set_sprite_data(5, 5, CAN);
	ld	de, #_CAN
	push	de
	ld	hl, #0x505
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x05
;main.c:63: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:64: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:65: }
	ret
;main.c:67: UINT8 randomRange(UINT8 start, UINT8 end) {
;	---------------------------------
; Function randomRange
; ---------------------------------
_randomRange::
;main.c:68: return start + ((UINT8)rand()) % (end - start + (UINT8)1);
	call	_rand
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	d, #0x00
	ld	c, (hl)
	ld	b, #0x00
	sub	a, c
	ld	c, a
	ld	a, d
	sbc	a, b
	ld	b, a
	inc	bc
	ld	d, #0x00
	push	bc
	push	de
	call	__modsint
	add	sp, #4
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, e
	ld	e, a
;main.c:69: }
	ret
;main.c:71: char collideWith() {
;	---------------------------------
; Function collideWith
; ---------------------------------
_collideWith::
;main.c:78: return '';
;main.c:79: }
	ret
;main.c:81: void onCatchFish(){
;	---------------------------------
; Function onCatchFish
; ---------------------------------
_onCatchFish::
;main.c:82: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
	ld	hl, #_fishingRod + 2
	ld	c, (hl)
	ld	hl, #_fishingRod + 3
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:82: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
;main.c:83: }
	ret
;main.c:85: void storeFish(){
;	---------------------------------
; Function storeFish
; ---------------------------------
_storeFish::
;main.c:87: if(fishingRod.spriteTile == fishingRod.hookSpriteFish) {
	ld	hl, #_fishingRod + 3
	ld	c, (hl)
	ld	a, (#(_fishingRod + 2) + 0)
	sub	a, c
	ret	NZ
;main.c:88: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
	ld	hl, #_fishingRod + 1
	ld	e, (hl)
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), e
;main.c:88: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
;main.c:90: }
	ret
;main.c:92: void handleInput(){
;	---------------------------------
; Function handleInput
; ---------------------------------
_handleInput::
;main.c:93: switch(joypad()) {
	call	_joypad
	ld	a, e
	cp	a, #0x04
	jr	Z, 00104$
	cp	a, #0x08
	jr	Z, 00107$
	sub	a, #0x10
	ret	NZ
;main.c:96: if(fishingRod.yHook<=30) {
	ld	hl, #_fishingRod
	ld	c, (hl)
	ld	a, #0x1e
	sub	a, c
	jr	C, 00104$
;main.c:97: storeFish();
	call	_storeFish
;main.c:100: case J_UP:
00104$:
;main.c:101: if(fishingRod.yHook > 20) {
	ld	bc, #_fishingRod+0
	ld	a, (bc)
	ld	e, a
	ld	a, #0x14
	sub	a, e
	ret	NC
;main.c:102: fishingRod.yHook -= 1;
	ld	a, e
	dec	a
	ld	(bc), a
;main.c:104: color(WHITE, WHITE, SOLID);
	push	bc
	xor	a, a
	rrca
	push	af
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
;main.c:101: if(fishingRod.yHook > 20) {
	ld	a, (bc)
;main.c:105: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 14);
	ld	c, a
	add	a, #0xf2
	ld	b, a
	ld	a, c
	add	a, #0xf0
	push	bc
	inc	sp
	ld	h, #0x50
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x50
	push	hl
	call	_line
	add	sp, #4
;main.c:107: break;
	ret
;main.c:109: case J_DOWN:
00107$:
;main.c:110: if(fishingRod.yHook<152) {
	ld	bc, #_fishingRod+0
	ld	a, (bc)
	cp	a, #0x98
	ret	NC
;main.c:111: fishingRod.yHook += 1;
	inc	a
	ld	(bc), a
;main.c:112: color(BLACK, BLACK, SOLID);
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x03
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
;main.c:110: if(fishingRod.yHook<152) {
	ld	a, (bc)
;main.c:113: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 17);
	ld	c, a
	add	a, #0xef
	ld	b, a
	ld	a, c
	add	a, #0xf0
	push	bc
	inc	sp
	ld	h, #0x50
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x50
	push	hl
	call	_line
	add	sp, #4
;main.c:116: }
;main.c:117: }
	ret
;main.c:119: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:120: init();
	call	_init
;main.c:122: printf(" \n\n\n\n\n\n\n\n    PRESS START!\n");
	ld	de, #___str_1
	push	de
	call	_puts
	pop	hl
;main.c:123: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:124: seed = LY_REG;
	ldh	a, (_LY_REG + 0)
;setupPair	HL
	ld	hl, #_seed
;setupPair	HL
	ld	(hl+), a
;main.c:125: seed |= (UINT16)DIV_REG << 8;
;setupPair	HL
	xor	a, a
	ld	(hl-), a
	ldh	a, (_DIV_REG + 0)
	ld	c, a
	xor	a, a
	or	a, (hl)
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, c
	or	a, (hl)
;setupPair	HL
;main.c:126: initrand(seed);
;setupPair	HL
	ld	(hl-), a
;setupPair	HL
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_initrand
	pop	hl
;main.c:128: printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	ld	de, #___str_3
	push	de
	call	_puts
	pop	hl
;main.c:130: line(80, 0, 80, fishingRod.yHook - 16);
	ld	a, (#_fishingRod + 0)
	add	a, #0xf0
	ld	h, a
	ld	l, #0x50
	push	hl
	ld	hl, #0x50
	push	hl
	call	_line
	add	sp, #4
;main.c:132: color(LTGREY, LTGREY, SOLID);
	xor	a, a
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	call	_color
	add	sp, #3
;main.c:133: line(0, 20, 70, 20);
	ld	hl, #0x1446
	push	hl
	ld	hl, #0x1400
	push	hl
	call	_line
	add	sp, #4
;main.c:134: line(90, 20, 159, 20);
	ld	hl, #0x149f
	push	hl
	ld	hl, #0x145a
	push	hl
	call	_line
	add	sp, #4
;main.c:136: moveFishTo(&fish1, 40, 40);
	ld	hl, #0x2828
	push	hl
	ld	de, #_fish1
	push	de
	call	_moveFishTo
	add	sp, #4
;main.c:138: while(1) {
00104$:
;main.c:139: wait_vbl_done();
	call	_wait_vbl_done
;main.c:140: moveFishTo(&fish1, fish1.x + 1, fish1.y);
	ld	hl, #(_fish1 + 1)
	ld	b, (hl)
	ld	a, (#_fish1 + 0)
	inc	a
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	de, #_fish1
	push	de
	call	_moveFishTo
	add	sp, #4
;main.c:141: handleInput();
	call	_handleInput
;main.c:142: move_sprite(fishingRod.spriteTile, 84, fishingRod.yHook);
	ld	hl, #_fishingRod
	ld	c, (hl)
	ld	hl, #(_fishingRod + 3)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x54
;main.c:143: move_sprite(5, i, 100); // can
;setupPair	HL
	ld	hl, #_i
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x64
	ld	(hl+), a
	ld	(hl), c
;main.c:144: if(fish1.x > 160) {
	ld	hl, #_fish1
	ld	c, (hl)
	ld	a, #0xa0
	sub	a, c
	jr	NC, 00104$
;main.c:145: fish1.y = randomRange(40, 150);
	ld	hl, #0x9628
	push	hl
	call	_randomRange
	pop	hl
	ld	a, e
	ld	(#(_fish1 + 1)),a
;main.c:146: fish1.x = 0;
	ld	hl, #_fish1
	ld	(hl), #0x00
;main.c:149: }
	jr	00104$
___str_1:
	.ascii " "
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "    PRESS START!"
	.db 0x00
___str_3:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__i:
	.db #0x00	; 0
	.area _CABS (ABS)
