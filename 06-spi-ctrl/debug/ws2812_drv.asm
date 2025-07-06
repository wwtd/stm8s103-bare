;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module ws2812_drv
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ws2812_set_one_color
	.globl _ws2812_set_all_color
	.globl _ws2812_blink
	.globl _ws2812_refresh
	.globl _ws2812_init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_gs_ws2812_config:
	.ds 64
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/ws2812_drv.c: 69: void ws2812_init(void)
;	-----------------------------------------
;	 function ws2812_init
;	-----------------------------------------
_ws2812_init:
;	src/ws2812_drv.c: 71: GPIO_D_BASE_ADDR->DDR |= (1 << 4);
	bset	0x5011, #4
;	src/ws2812_drv.c: 72: GPIO_D_BASE_ADDR->CR1 |= (1 << 4);
	bset	0x5012, #4
;	src/ws2812_drv.c: 73: }
	ret
;	src/ws2812_drv.c: 75: void ws2812_refresh(void)
;	-----------------------------------------
;	 function ws2812_refresh
;	-----------------------------------------
_ws2812_refresh:
	sub	sp, #11
;	src/ws2812_drv.c: 77: for(uint16_t i = 0; i< WS2812_CONTRL_BIT * WS2812_SERIAL_NUM; ++i)
	clrw	x
	ldw	(0x0a, sp), x
00106$:
	ldw	y, (0x0a, sp)
	ldw	(0x08, sp), y
	ldw	x, y
	cpw	x, #0x0180
	jrnc	00104$
;	src/ws2812_drv.c: 79: if((gs_ws2812_config[i/WS2812_CONTRL_BIT] >> (i%WS2812_CONTRL_BIT)) & 0x1)
	ldw	x, (0x08, sp)
	ldw	y, #0x0018
	divw	x, y
	sllw	x
	sllw	x
	addw	x, #(_gs_ws2812_config+0)
	ld	a, (0x3, x)
	ld	(0x04, sp), a
	ld	a, (0x2, x)
	ld	(0x03, sp), a
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	x, (0x08, sp)
	ldw	y, #0x0018
	divw	x, y
	ldw	(0x08, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x06, sp), y
	ldw	x, (0x03, sp)
	ld	a, (0x09, sp)
	jreq	00128$
00127$:
	srl	(0x06, sp)
	rrc	(0x07, sp)
	rrcw	x
	dec	a
	jrne	00127$
00128$:
	ldw	(0x08, sp), x
	ld	a, (0x09, sp)
	srl	a
	jrnc	00102$
;	src/ws2812_drv.c: 81: ws2812_send_1;
	bset	20495, #4
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	bres	20495, #4
	nop
	nop
	nop
	jra	00107$
00102$:
;	src/ws2812_drv.c: 85: ws2812_send_0;
	bset	20495, #4
	nop
	nop
	nop
	nop
	nop
	bres	20495, #4
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
00107$:
;	src/ws2812_drv.c: 77: for(uint16_t i = 0; i< WS2812_CONTRL_BIT * WS2812_SERIAL_NUM; ++i)
	ldw	x, (0x0a, sp)
	incw	x
	ldw	(0x0a, sp), x
	jra	00106$
00104$:
;	src/ws2812_drv.c: 88: ws2812_reset;
	bres	20495, #4
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
;	src/ws2812_drv.c: 89: }
	addw	sp, #11
	ret
;	src/ws2812_drv.c: 91: void ws2812_blink(void)
;	-----------------------------------------
;	 function ws2812_blink
;	-----------------------------------------
_ws2812_blink:
	sub	sp, #10
;	src/ws2812_drv.c: 93: for(uint16_t i = 0; i < WS2812_SERIAL_NUM; ++i)
	clrw	x
	ldw	(0x09, sp), x
00103$:
;	src/ws2812_drv.c: 95: gs_ws2812_config[i] +=10;
	ldw	x, (0x09, sp)
	cpw	x, #0x0010
	jrnc	00101$
	sllw	x
	sllw	x
	addw	x, #(_gs_ws2812_config+0)
	ldw	y, x
	ldw	y, (0x2, y)
	ld	a, (0x1, x)
	push	a
	ld	a, (x)
	ld	(0x06, sp), a
	pop	a
	addw	y, #0x000a
	adc	a, #0x00
	push	a
	ld	a, (0x06, sp)
	adc	a, #0x00
	ld	(0x02, sp), a
	pop	a
	ldw	(0x2, x), y
	ld	(0x1, x), a
	push	a
	ld	a, (0x02, sp)
	ld	(x), a
	pop	a
;	src/ws2812_drv.c: 96: gs_ws2812_config[i] %=0x1000000;
	ld	(0x06, sp), a
	clr	(0x05, sp)
	ldw	(0x2, x), y
	ldw	y, (0x05, sp)
	ldw	(x), y
;	src/ws2812_drv.c: 93: for(uint16_t i = 0; i < WS2812_SERIAL_NUM; ++i)
	ldw	x, (0x09, sp)
	incw	x
	ldw	(0x09, sp), x
	jra	00103$
00101$:
;	src/ws2812_drv.c: 98: return;
;	src/ws2812_drv.c: 99: }
	addw	sp, #10
	ret
;	src/ws2812_drv.c: 101: void ws2812_set_all_color(uint32_t color)
;	-----------------------------------------
;	 function ws2812_set_all_color
;	-----------------------------------------
_ws2812_set_all_color:
;	src/ws2812_drv.c: 103: if(color > 0xFFFFFF)
	tnz	(0x03, sp)
;	src/ws2812_drv.c: 105: return;
;	src/ws2812_drv.c: 107: for(int i =0; i< WS2812_SERIAL_NUM; ++i)
	jrne	00107$
	clrw	y
00105$:
;	src/ws2812_drv.c: 109: gs_ws2812_config[i] = color;
	ldw	x, y
	cpw	x, #0x0010
	jrnc	00107$
	sllw	x
	sllw	x
	addw	x, #(_gs_ws2812_config+0)
	ld	a, (0x06, sp)
	ld	(0x3, x), a
	ld	a, (0x05, sp)
	ld	(0x2, x), a
	ld	a, (0x04, sp)
	ld	(0x1, x), a
	ld	a, (0x03, sp)
	ld	(x), a
;	src/ws2812_drv.c: 107: for(int i =0; i< WS2812_SERIAL_NUM; ++i)
	incw	y
	jra	00105$
00107$:
;	src/ws2812_drv.c: 111: }
	ldw	x, (1, sp)
	addw	sp, #6
	jp	(x)
;	src/ws2812_drv.c: 113: void ws2812_set_one_color(uint16_t index, uint32_t color)
;	-----------------------------------------
;	 function ws2812_set_one_color
;	-----------------------------------------
_ws2812_set_one_color:
;	src/ws2812_drv.c: 115: if((color > 0xFFFFFF) || (index > WS2812_SERIAL_NUM))
	tnz	(0x03, sp)
	jrne	00104$
	ldw	y, x
	cpw	y, #0x0010
;	src/ws2812_drv.c: 117: return;
	jrugt	00104$
;	src/ws2812_drv.c: 119: gs_ws2812_config[index] = color;
	sllw	x
	sllw	x
	addw	x, #(_gs_ws2812_config+0)
	ldw	y, (0x05, sp)
	ldw	(0x2, x), y
	ldw	y, (0x03, sp)
	ldw	(x), y
00104$:
;	src/ws2812_drv.c: 120: }
	ldw	x, (1, sp)
	addw	sp, #6
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__gs_ws2812_config:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.area CABS (ABS)
