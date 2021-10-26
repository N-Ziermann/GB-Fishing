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
	.globl _collideWith
	.globl _storeFish
	.globl _onCatchFish
	.globl _doesCollide
	.globl _init
	.globl _moveCanTo
	.globl _moveFishTo
	.globl _randomRange
	.globl _rand
	.globl _initrand
	.globl _puts
	.globl _color
	.globl _gotogxy
	.globl _line
	.globl _gprintf
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _reset
	.globl _waitpad
	.globl _joypad
	.globl _caughtFishIndex
	.globl _score
	.globl _framecounter
	.globl _seed
	.globl _fishingRod
	.globl _canArr
	.globl _fishArr
	.globl _spriteSize
	.globl _hookX
	.globl _scoreHigherDigit
	.globl _scoreLowerDigit
	.globl _NUMBERS
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
_fishArr::
	.ds 5
_canArr::
	.ds 12
_fishingRod::
	.ds 4
_seed::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_framecounter::
	.ds 2
_score::
	.ds 1
_caughtFishIndex::
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
;main.c:53: UINT8 randomRange(UINT8 start, UINT8 end) {
;	---------------------------------
; Function randomRange
; ---------------------------------
_randomRange::
;main.c:54: return start + ((UINT8)rand()) % (end - start + (UINT8)1);
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
;main.c:55: }
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
_NUMBERS:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x85	; 133
	.db #0x85	; 133
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x91	; 145
	.db #0x91	; 145
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
_scoreLowerDigit:
	.db #0x0a	; 10
_scoreHigherDigit:
	.db #0x0b	; 11
_hookX:
	.db #0x54	; 84	'T'
_spriteSize:
	.db #0x08	; 8
;main.c:57: void moveFishTo(Fish *f, UINT8 x, UINT8 y) {
;	---------------------------------
; Function moveFishTo
; ---------------------------------
_moveFishTo::
	add	sp, #-4
;main.c:58: if(f->index == caughtFishIndex) {
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	e, (hl)
	ld	d, #0x00
;setupPair	HL
	ld	a, (#_caughtFishIndex)
	ldhl	sp,	#2
	ld	(hl+), a
	rlca
	sbc	a, a
	ld	(hl), a
;main.c:60: f->y = randomRange(40, 150);
	ld	l, c
	ld	h, b
	inc	hl
	inc	sp
	inc	sp
	push	hl
;main.c:58: if(f->index == caughtFishIndex) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00104$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00104$
;main.c:59: f->x = 0;
	xor	a, a
	ld	(bc), a
;main.c:60: f->y = randomRange(40, 150);
	push	bc
	ld	hl, #0x9628
	push	hl
	call	_randomRange
	pop	hl
	ld	a, e
	pop	bc
	pop	hl
	push	hl
	ld	(hl), a
	jr	00105$
00104$:
;main.c:62: f->x = x;
	ldhl	sp,	#8
;main.c:63: f->y = y;
	ld	a, (hl+)
	ld	(bc), a
	pop	de
	push	de
;main.c:64: if(f->x > 160) {
	ld	a, (hl-)
	ld	(de), a
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00105$
;main.c:65: f->y = randomRange(40, 150);
	push	bc
	ld	hl, #0x9628
	push	hl
	call	_randomRange
	pop	hl
	ld	a, e
	pop	bc
	pop	hl
	push	hl
	ld	(hl), a
;main.c:66: f->x = 0;
	xor	a, a
	ld	(bc), a
00105$:
;main.c:69: move_sprite(f->sprites[0], f->x, f->y);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (bc)
	ld	(hl), a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	e, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:70: move_sprite(f->sprites[1], f->x - spriteSize, f->y);
	pop	de
	push	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (bc)
;setupPair	HL
	ld	hl, #_spriteSize
	ld	e, (hl)
	sub	a, e
	ld	e, a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, e
	ld	(bc), a
;main.c:70: move_sprite(f->sprites[1], f->x - spriteSize, f->y);
;main.c:71: }
	add	sp, #4
	ret
;main.c:73: void moveCanTo(Can *c, UINT8 x, UINT8 y) {
;	---------------------------------
; Function moveCanTo
; ---------------------------------
_moveCanTo::
	dec	sp
;main.c:74: if(framecounter % c->moveEveryXFrames == 0) {
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
;setupPair	HL
	ld	hl, #_framecounter
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	__moduint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	NZ, 00106$
;main.c:75: c->x = x;
	ldhl	sp,	#5
;main.c:76: c->y = y;
	ld	a, (hl+)
	ld	(bc), a
	ld	e, c
	ld	d, b
	inc	de
;main.c:77: if(c->x > 160) {
	ld	a, (hl-)
	ld	(de), a
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00102$
;main.c:78: c->y = randomRange(40, 150);
	push	bc
	push	de
	ld	hl, #0x9628
	push	hl
	call	_randomRange
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	ld	(de), a
;main.c:79: c->x = 0;
	xor	a, a
	ld	(bc), a
00102$:
;main.c:81: move_sprite(c->sprite, c->x, c->y);
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl), a
	inc	bc
	inc	bc
	ld	a, (bc)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
;main.c:81: move_sprite(c->sprite, c->x, c->y);
00106$:
;main.c:83: }
	inc	sp
	ret
;main.c:85: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:87: fishArr[0].sprites[0] = 1;
	ld	bc, #_fishArr + 2
	ld	a, #0x01
	ld	(bc), a
;main.c:88: fishArr[0].sprites[1] = 2;
	ld	hl, #(_fishArr + 3)
	ld	(hl), #0x02
;main.c:89: fishArr[0].index = 0;
	ld	hl, #(_fishArr + 4)
	ld	(hl), #0x00
;main.c:90: set_sprite_data(1, 2, FISH);
	ld	de, #_FISH
	push	de
	ld	hl, #0x201
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:91: set_sprite_tile(fishArr[0].sprites[0], 1);
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
;main.c:92: set_sprite_tile(fishArr[0].sprites[1], 2);
	ld	hl, #(_fishArr + 3)
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
;main.c:94: fishingRod.yHook = 20;
	ld	hl, #_fishingRod
	ld	(hl), #0x14
;main.c:95: fishingRod.hookSprite = 3;
	ld	bc, #_fishingRod + 1
	ld	a, #0x03
	ld	(bc), a
;main.c:96: fishingRod.hookSpriteFish = 4;
	ld	hl, #(_fishingRod + 2)
	ld	(hl), #0x04
;main.c:97: fishingRod.spriteTile = 3;
	ld	hl, #(_fishingRod + 3)
	ld	(hl), #0x03
;main.c:98: set_sprite_data(3, 4, ROD);
	ld	de, #_ROD
	push	de
	ld	hl, #0x403
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:99: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
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
;main.c:101: set_sprite_data(5, 5, CAN);
	ld	de, #_CAN
	push	de
	ld	hl, #0x505
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:102: canArr[0].sprite = 5;
	ld	bc, #_canArr + 2
	ld	a, #0x05
	ld	(bc), a
;main.c:103: canArr[0].x = 50;
	ld	hl, #_canArr
	ld	(hl), #0x32
;main.c:104: canArr[0].y = 125;
	ld	hl, #(_canArr + 1)
	ld	(hl), #0x7d
;main.c:105: canArr[0].moveEveryXFrames = 1;
	ld	hl, #(_canArr + 3)
	ld	(hl), #0x01
;main.c:106: set_sprite_tile(canArr[0].sprite, 5);
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
	ld	(hl), #0x05
;main.c:107: canArr[1].sprite = 7;
	ld	bc, #_canArr + 6
	ld	a, #0x07
	ld	(bc), a
;main.c:108: canArr[1].x = 90;
	ld	hl, #(_canArr + 4)
	ld	(hl), #0x5a
;main.c:109: canArr[1].y = 145;
	ld	hl, #(_canArr + 5)
	ld	(hl), #0x91
;main.c:110: canArr[1].moveEveryXFrames = 2;
	ld	hl, #(_canArr + 7)
	ld	(hl), #0x02
;main.c:111: set_sprite_tile(canArr[1].sprite, 5);
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
	ld	(hl), #0x05
;main.c:112: canArr[2].sprite = 8;
	ld	bc, #_canArr + 10
	ld	a, #0x08
	ld	(bc), a
;main.c:113: canArr[2].x = 70;
	ld	hl, #(_canArr + 8)
	ld	(hl), #0x46
;main.c:114: canArr[2].y = 105;
	ld	hl, #(_canArr + 9)
	ld	(hl), #0x69
;main.c:115: canArr[2].moveEveryXFrames = 3;
	ld	hl, #(_canArr + 11)
	ld	(hl), #0x03
;main.c:116: set_sprite_tile(canArr[2].sprite, 5);
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
	ld	(hl), #0x05
;main.c:118: set_sprite_data(6, 15, NUMBERS);
	ld	de, #_NUMBERS
	push	de
	ld	hl, #0xf06
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:119: set_sprite_tile(scoreLowerDigit, 6);
;setupPair	HL
	ld	hl, #_scoreLowerDigit
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
	ld	(hl), #0x06
;main.c:120: set_sprite_tile(scoreHigherDigit, 6);
;setupPair	HL
	ld	hl, #_scoreHigherDigit
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
	ld	(hl), #0x06
;main.c:122: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:123: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:124: }
	ret
;main.c:126: bool doesCollide(UINT8 x1, UINT8 y1, UINT8 x2, UINT8 y2) {
;	---------------------------------
; Function doesCollide
; ---------------------------------
_doesCollide::
	add	sp, #-6
;main.c:127: if (x1 < x2 + spriteSize &&
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
;setupPair	HL
	ld	a, (#_spriteSize)
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	pop	de
	push	de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00128$
	bit	7, d
	jr	NZ, 00129$
	cp	a, a
	jr	00129$
00128$:
	bit	7, d
	jr	Z, 00129$
	scf
00129$:
	jr	NC, 00102$
;main.c:128: x1 + spriteSize > x2 &&
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00130$
	bit	7, d
	jr	NZ, 00131$
	cp	a, a
	jr	00131$
00130$:
	bit	7, d
	jr	Z, 00131$
	scf
00131$:
	jr	NC, 00102$
;main.c:129: y1 < y2 + spriteSize &&
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00132$
	bit	7, d
	jr	NZ, 00133$
	cp	a, a
	jr	00133$
00132$:
	bit	7, d
	jr	Z, 00133$
	scf
00133$:
	jr	NC, 00102$
;main.c:130: y1 + spriteSize > y2) {
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00134$
	bit	7, d
	jr	NZ, 00135$
	cp	a, a
	jr	00135$
00134$:
	bit	7, d
	jr	Z, 00135$
	scf
00135$:
	jr	NC, 00102$
;main.c:131: return true;
	ld	e, #0x01
	jr	00106$
00102$:
;main.c:133: return false;
	ld	e, #0x00
00106$:
;main.c:134: }
	add	sp, #6
	ret
;main.c:137: void onCatchFish(){
;	---------------------------------
; Function onCatchFish
; ---------------------------------
_onCatchFish::
;main.c:138: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
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
;main.c:138: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSpriteFish);
;main.c:139: }
	ret
;main.c:141: void storeFish(){
;	---------------------------------
; Function storeFish
; ---------------------------------
_storeFish::
;main.c:143: if(caughtFishIndex != -1) {
;setupPair	HL
	ld	a, (#_caughtFishIndex)
	inc	a
	ret	Z
;main.c:144: set_sprite_tile(fishingRod.spriteTile, fishingRod.hookSprite);
	ld	hl, #(_fishingRod + 1)
	ld	c, (hl)
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
;main.c:145: caughtFishIndex = -1;
;setupPair	HL
	ld	hl, #_caughtFishIndex
	ld	(hl), #0xff
;main.c:146: score++;
;setupPair	HL
	ld	hl, #_score
	inc	(hl)
;main.c:148: }
	ret
;main.c:150: void collideWith() {
;	---------------------------------
; Function collideWith
; ---------------------------------
_collideWith::
	dec	sp
	dec	sp
;main.c:152: for(UINT8 i = 0; i < numFish; i++) {
	ld	b, #0x00
00110$:
	ld	a, b
	sub	a, #0x01
	jr	NC, 00103$
;main.c:153: if( doesCollide(hookX + 1, fishingRod.yHook, fishArr[i].x, fishArr[i].y) ) {
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	de, #_fishArr
	add	hl, de
	ld	e, l
	ld	d, h
	inc	de
	ld	a, (de)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (#_fishingRod + 0)
;setupPair	HL
	ld	hl, #_hookX
	ld	d, (hl)
	inc	d
	push	bc
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	push	de
	inc	sp
	call	_doesCollide
	add	sp, #4
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00111$
;main.c:154: onCatchFish();
	push	bc
	call	_onCatchFish
	pop	bc
;main.c:155: caughtFishIndex = i;
;setupPair	HL
	ld	hl, #_caughtFishIndex
	ld	(hl), b
00111$:
;main.c:152: for(UINT8 i = 0; i < numFish; i++) {
	inc	b
	jr	00110$
00103$:
;main.c:158: for(UINT8 i=0; i < numCans; i++) {
	ld	c, #0x00
00113$:
	ld	a, c
	sub	a, #0x03
	jr	NC, 00115$
;main.c:159: if(canArr[i].x != NULL) {
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #_canArr
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	b, a
	or	a, a
	jr	Z, 00114$
;main.c:160: if( doesCollide(hookX + 1, fishingRod.yHook, canArr[i].x, canArr[i].y) ) {
	pop	de
	push	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (#_fishingRod + 0)
;setupPair	HL
	ld	hl, #_hookX
	ld	e, (hl)
	inc	e
	push	bc
	ldhl	sp,	#3
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	ld	d,a
	push	de
	call	_doesCollide
	add	sp, #4
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00114$
;main.c:161: color(BLACK,WHITE,SOLID);
	push	bc
	xor	a, a
	rrca
	push	af
	xor	a, a
	ld	a, #0x03
	push	af
	inc	sp
	call	_color
	add	sp, #3
	ld	hl, #0x805
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_0
	push	de
	call	_gprintf
	pop	hl
	pop	bc
;main.c:164: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:165: reset();
	push	bc
	call	_reset
	pop	bc
00114$:
;main.c:158: for(UINT8 i=0; i < numCans; i++) {
	inc	c
	jr	00113$
00115$:
;main.c:169: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "GAME OVER!"
	.db 0x00
;main.c:171: void handleInput(){
;	---------------------------------
; Function handleInput
; ---------------------------------
_handleInput::
;main.c:172: switch(joypad()) {
	call	_joypad
	ld	a, e
	cp	a, #0x04
	jr	Z, 00104$
	cp	a, #0x08
	jr	Z, 00107$
	sub	a, #0x10
	ret	NZ
;main.c:175: if(fishingRod.yHook<=30) {
	ld	hl, #_fishingRod
	ld	c, (hl)
	ld	a, #0x1e
	sub	a, c
	ret	C
;main.c:176: storeFish();
;main.c:178: break;
	jp	_storeFish
;main.c:180: case J_UP:
00104$:
;main.c:181: if(fishingRod.yHook > 20) {
	ld	bc, #_fishingRod+0
	ld	a, (bc)
	ld	e, a
	ld	a, #0x14
	sub	a, e
	ret	NC
;main.c:182: fishingRod.yHook -= 1;
	ld	a, e
	dec	a
	ld	(bc), a
;main.c:184: color(WHITE, WHITE, SOLID);
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
;main.c:181: if(fishingRod.yHook > 20) {
	ld	a, (bc)
;main.c:185: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 14);
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
;main.c:187: break;
	ret
;main.c:189: case J_DOWN:
00107$:
;main.c:190: if(fishingRod.yHook<152) {
	ld	a, (#_fishingRod + 0)
	cp	a, #0x98
	ret	NC
;main.c:191: fishingRod.yHook += 1;
	inc	a
	ld	(#_fishingRod),a
;main.c:192: color(BLACK, BLACK, SOLID);
	xor	a, a
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x03
	push	af
	inc	sp
	call	_color
	add	sp, #3
;main.c:190: if(fishingRod.yHook<152) {
	ld	a, (#_fishingRod + 0)
;main.c:193: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 17);
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
;main.c:196: }
;main.c:197: }
	ret
;main.c:199: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:200: init();
	call	_init
;main.c:202: printf(" \n\n\n\n\n\n\n\n    PRESS START!\n");
	ld	de, #___str_2
	push	de
	call	_puts
	pop	hl
;main.c:203: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:204: seed = LY_REG;
	ldh	a, (_LY_REG + 0)
;setupPair	HL
	ld	hl, #_seed
;setupPair	HL
	ld	(hl+), a
;main.c:205: seed |= (UINT16)DIV_REG << 8;
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
;main.c:206: initrand(seed);
;setupPair	HL
	ld	(hl-), a
;setupPair	HL
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_initrand
	pop	hl
;main.c:208: printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	ld	de, #___str_4
	push	de
	call	_puts
	pop	hl
;main.c:210: line(80, 0, 80, fishingRod.yHook - 16);
	ld	a, (#_fishingRod + 0)
	add	a, #0xf0
	ld	h, a
	ld	l, #0x50
	push	hl
	ld	hl, #0x50
	push	hl
	call	_line
	add	sp, #4
;main.c:212: color(LTGREY, LTGREY, SOLID);
	xor	a, a
	ld	h, a
	ld	l, #0x01
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	call	_color
	add	sp, #3
;main.c:213: line(0, 20, 70, 20);
	ld	hl, #0x1446
	push	hl
	ld	hl, #0x1400
	push	hl
	call	_line
	add	sp, #4
;main.c:214: line(90, 20, 159, 20);
	ld	hl, #0x149f
	push	hl
	ld	hl, #0x145a
	push	hl
	call	_line
	add	sp, #4
;main.c:216: moveFishTo(&fishArr[0], 40, 40);
	ld	hl, #0x2828
	push	hl
	ld	de, #_fishArr
	push	de
	call	_moveFishTo
	add	sp, #4
;main.c:218: while(1) {
00103$:
;main.c:219: framecounter++;
;setupPair	HL
	ld	hl, #_framecounter
	inc	(hl)
	jr	NZ, 00131$
;setupPair	HL
	inc	hl
	inc	(hl)
00131$:
;main.c:220: UINT8 joydata = joypad();
	call	_joypad
;main.c:221: handleInput();
	call	_handleInput
;main.c:222: moveFishTo(&fishArr[0], fishArr[0].x + 2, fishArr[0].y);
	ld	hl, #_fishArr + 1
	ld	b, (hl)
	ld	a, (#_fishArr + 0)
	add	a, #0x02
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	de, #_fishArr
	push	de
	call	_moveFishTo
	add	sp, #4
;main.c:223: move_sprite(fishingRod.spriteTile, hookX, fishingRod.yHook);
	ld	hl, #_fishingRod
	ld	b, (hl)
;setupPair	HL
	ld	hl, #_hookX
	ld	c, (hl)
	ld	de, #_fishingRod+3
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:225: for(UINT8 i =0; i<numCans; i++) {
	ld	c, #0x00
00111$:
	ld	a, c
	sub	a, #0x03
	jr	NC, 00101$
;main.c:226: moveCanTo(&canArr[i], canArr[i].x + 2, canArr[i].y);
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_canArr
	add	hl, de
	ld	e, l
	ld	d, h
	inc	de
	ld	a, (de)
	ld	b, (hl)
	inc	b
	inc	b
	push	bc
	push	af
	inc	sp
	push	bc
	inc	sp
	push	hl
	call	_moveCanTo
	add	sp, #4
	pop	bc
;main.c:225: for(UINT8 i =0; i<numCans; i++) {
	inc	c
	jr	00111$
00101$:
;main.c:229: set_sprite_tile(scoreLowerDigit, 6 + (score % 10));
;setupPair	HL
	ld	hl, #_score
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x000a
	push	de
	push	bc
	call	__modsint
	add	sp, #4
	ld	a, e
	add	a, #0x06
	ld	e, a
;setupPair	HL
	ld	hl, #_scoreLowerDigit
	ld	c, (hl)
	ld	b, c
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), e
;main.c:230: set_sprite_tile(scoreHigherDigit, 6 + (score / 10));
;setupPair	HL
	ld	hl, #_score
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x000a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ld	a, e
	add	a, #0x06
	ld	e, a
;setupPair	HL
	ld	hl, #_scoreHigherDigit
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), e
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x14
	ld	(hl+), a
	ld	(hl), #0x9f
;main.c:232: move_sprite(scoreHigherDigit, 150, 20);
;setupPair	HL
	ld	hl, #_scoreHigherDigit
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x14
	ld	(hl+), a
	ld	(hl), #0x96
;main.c:233: collideWith();
	call	_collideWith
;main.c:234: wait_vbl_done();
	call	_wait_vbl_done
;main.c:236: }
	jp	00103$
___str_2:
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
___str_4:
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
__xinit__framecounter:
	.dw #0x0000
__xinit__score:
	.db #0x00	; 0
__xinit__caughtFishIndex:
	.db #0xff	; -1
	.area _CABS (ABS)
