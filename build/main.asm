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
	.globl _randomRange
	.globl _init
	.globl _moveFishTo
	.globl _rand
	.globl _initrand
	.globl _puts
	.globl _printf
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
	.ds 2
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
;main.c:37: void moveFishTo(Fish *f, UINT8 x, UINT8 y) {
;	---------------------------------
; Function moveFishTo
; ---------------------------------
_moveFishTo::
	dec	sp
	dec	sp
;main.c:38: f->x = x;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
;main.c:39: f->y = y;
	ld	a, (hl+)
	ld	(de), a
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:40: move_sprite(f->sprites[0], x, y);
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
;main.c:41: move_sprite(f->sprites[1], x-spriteSize, y);
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
;main.c:41: move_sprite(f->sprites[1], x-spriteSize, y);
;main.c:42: }
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
;main.c:44: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:45: fish1.sprites[0] = 1;
	ld	hl, #(_fish1 + 2)
	ld	(hl), #0x01
;main.c:46: fish1.sprites[1] = 2;
	ld	hl, #(_fish1 + 3)
	ld	(hl), #0x02
;main.c:47: moveFishTo(&fish1, 20, 30);
	ld	hl, #0x1e14
	push	hl
	ld	de, #_fish1
	push	de
	call	_moveFishTo
	add	sp, #4
;main.c:48: set_sprite_data(1, 2, FISH);
	ld	de, #_FISH
	push	de
	ld	hl, #0x201
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:49: set_sprite_tile(fish1.sprites[0], 1);
	ld	hl, #(_fish1 + 2)
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
	ld	(hl), #0x01
;main.c:50: set_sprite_tile(fish1.sprites[1], 2);
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
;main.c:51: fishingRod.yHook = 100;
	ld	hl, #_fishingRod
	ld	(hl), #0x64
;main.c:52: fishingRod.hookSprite = 3;
	ld	bc, #_fishingRod+1
	ld	a, #0x03
	ld	(bc), a
;main.c:53: set_sprite_data(3, 3, ROD);
	ld	de, #_ROD
	push	de
	ld	hl, #0x303
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:54: set_sprite_tile(fishingRod.hookSprite, 3);
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
	ld	(hl), #0x03
;main.c:55: set_sprite_data(4, 4, CAN);
	ld	de, #_CAN
	push	de
	ld	hl, #0x404
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x04
;main.c:57: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:58: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:59: }
	ret
;main.c:61: UINT8 randomRange(UINT8 start, UINT8 end) {
;	---------------------------------
; Function randomRange
; ---------------------------------
_randomRange::
;main.c:62: return start + ((UINT8)rand()) % (end - start + (UINT8)1);
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
;main.c:63: }
	ret
;main.c:65: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:66: init();
	call	_init
;main.c:68: printf("PRESS START!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;main.c:69: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:70: seed = LY_REG;
	ldh	a, (_LY_REG + 0)
;setupPair	HL
	ld	hl, #_seed
;setupPair	HL
	ld	(hl+), a
;main.c:71: seed |= (UINT16)DIV_REG << 8;
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
;main.c:72: initrand(seed);
;setupPair	HL
	ld	(hl-), a
;setupPair	HL
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_initrand
	pop	hl
;main.c:74: printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	ld	de, #___str_2
	push	de
	call	_puts
	pop	hl
;main.c:76: line(80, 0, 80, fishingRod.yHook - 16);
	ld	a, (#_fishingRod + 0)
	add	a, #0xf0
	ld	h, a
	ld	l, #0x50
	push	hl
	ld	hl, #0x50
	push	hl
	call	_line
	add	sp, #4
;main.c:78: while(1) {
00109$:
;main.c:79: wait_vbl_done();
	call	_wait_vbl_done
;main.c:80: moveFishTo(&fish1, fish1.x + 1, fish1.y);
	ld	bc, #_fish1+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	e, (hl)
	ld	a, (bc)
	inc	a
	ld	h, e
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	push	bc
	call	_moveFishTo
	add	sp, #4
;main.c:81: switch(joypad()) {
	call	_joypad
	ld	a, e
;main.c:76: line(80, 0, 80, fishingRod.yHook - 16);
	ld	hl, #_fishingRod
	ld	l, (hl)
;	spillPairReg hl
;main.c:84: fishingRod.yHook -= 1;
	ld	c, l
;main.c:81: switch(joypad()) {
	cp	a, #0x04
	jr	Z, 00101$
	sub	a, #0x08
	jr	Z, 00104$
	jr	00107$
;main.c:82: case J_UP:
00101$:
;main.c:83: if(fishingRod.yHook > 20) {
	ld	a, #0x14
	sub	a, l
	jr	NC, 00107$
;main.c:84: fishingRod.yHook -= 1;
	dec	c
	ld	hl, #_fishingRod
	ld	(hl), c
;main.c:86: color(WHITE, WHITE, SOLID);
	xor	a, a
	rrca
	push	af
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;main.c:76: line(80, 0, 80, fishingRod.yHook - 16);
	ld	a, (#_fishingRod + 0)
;main.c:84: fishingRod.yHook -= 1;
;main.c:87: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 14);
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
;main.c:88: color(BLACK, BLACK, SOLID);
	xor	a, a
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x03
	push	af
	inc	sp
	call	_color
	add	sp, #3
;main.c:90: break;
	jr	00107$
;main.c:91: case J_DOWN:
00104$:
;main.c:92: if(fishingRod.yHook<152) {
	ld	a, l
	sub	a, #0x98
	jr	NC, 00107$
;main.c:93: fishingRod.yHook += 1;
	inc	c
	ld	hl, #_fishingRod
	ld	(hl), c
;main.c:76: line(80, 0, 80, fishingRod.yHook - 16);
	ld	a, (#_fishingRod + 0)
;main.c:84: fishingRod.yHook -= 1;
;main.c:94: line(80, fishingRod.yHook - 16, 80, fishingRod.yHook - 17);
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
;main.c:97: }
00107$:
;main.c:98: move_sprite(fishingRod.hookSprite, 84,fishingRod.yHook);
	ld	hl, #_fishingRod
	ld	c, (hl)
	ld	hl, #(_fishingRod + 1)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
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
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x54
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x64
	ld	(hl+), a
	ld	(hl), #0x64
;main.c:99: move_sprite(4, 100, 100);
;main.c:101: }
	jp	00109$
___str_0:
	.ascii "PRESS START!"
	.db 0x00
___str_2:
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
