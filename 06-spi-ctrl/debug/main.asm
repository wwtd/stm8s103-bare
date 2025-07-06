;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _eeprom_get
	.globl _eeprom_set
	.globl _get_uid
	.globl _ws2812_set_one_color
	.globl _ws2812_refresh
	.globl _ws2812_init
	.globl _on_board_led_init
	.globl _enable_HSI_16MHz
	.globl _uart1_init
	.globl _faker_delay
	.globl _puts
	.globl _printf
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

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
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/main.c: 22: void main()
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #28
;	src/main.c: 24: enable_HSI_16MHz();
	call	_enable_HSI_16MHz
;	src/main.c: 25: on_board_led_init();
	call	_on_board_led_init
;	src/main.c: 26: uart1_init();
	call	_uart1_init
;	src/main.c: 27: ws2812_init();
	call	_ws2812_init
;	src/main.c: 29: for(int i = 0; i < 16; ++i)
	clrw	x
	ldw	(0x1b, sp), x
00114$:
	ldw	x, (0x1b, sp)
	cpw	x, #0x0010
	jrsge	00107$
;	src/main.c: 31: if(i%3 == 0)
	push	#0x03
	push	#0x00
	ldw	x, (0x1d, sp)
;	src/main.c: 33: ws2812_set_one_color(i, 0xFF);
	call	__modsint
	ldw	y, (0x1b, sp)
;	src/main.c: 31: if(i%3 == 0)
	tnzw	x
	jrne	00105$
;	src/main.c: 33: ws2812_set_one_color(i, 0xFF);
	push	#0xff
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, y
	call	_ws2812_set_one_color
	jra	00115$
00105$:
;	src/main.c: 35: else if(i%3 == 1)
	decw	x
	jrne	00102$
;	src/main.c: 37: ws2812_set_one_color(i, 0xFF00);
	push	#0x00
	push	#0xff
	clrw	x
	pushw	x
	ldw	x, y
	call	_ws2812_set_one_color
	jra	00115$
00102$:
;	src/main.c: 41: ws2812_set_one_color(i, 0xFF0000);
	clrw	x
	pushw	x
	push	#0xff
	push	#0x00
	ldw	x, y
	call	_ws2812_set_one_color
00115$:
;	src/main.c: 29: for(int i = 0; i < 16; ++i)
	ldw	x, (0x1b, sp)
	incw	x
	ldw	(0x1b, sp), x
	jra	00114$
00107$:
;	src/main.c: 45: uint8_t * tmp_uid = get_uid();
	call	_get_uid
	ldw	(0x19, sp), x
;	src/main.c: 47: uint8_t test_arr[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
	ldw	x, sp
	incw	x
	ld	a, #0x01
	ld	(x), a
	ld	a, #0x02
	ld	(0x02, sp), a
	ld	a, #0x03
	ld	(0x03, sp), a
	ld	a, #0x04
	ld	(0x04, sp), a
	ld	a, #0x05
	ld	(0x05, sp), a
	ld	a, #0x06
	ld	(0x06, sp), a
	ld	a, #0x07
	ld	(0x07, sp), a
	ld	a, #0x08
	ld	(0x08, sp), a
;	src/main.c: 48: eeprom_set(0, test_arr, sizeof(test_arr));
	push	#0x08
	push	#0x00
	pushw	x
	clrw	x
	call	_eeprom_set
;	src/main.c: 49: uint8_t print_arr[16] = {0};
	clr	(0x09, sp)
	clr	(0x0a, sp)
	clr	(0x0b, sp)
	clr	(0x0c, sp)
	clr	(0x0d, sp)
	clr	(0x0e, sp)
	clr	(0x0f, sp)
	clr	(0x10, sp)
	clr	(0x11, sp)
	clr	(0x12, sp)
	clr	(0x13, sp)
	clr	(0x14, sp)
	clr	(0x15, sp)
	clr	(0x16, sp)
	clr	(0x17, sp)
	clr	(0x18, sp)
;	src/main.c: 50: eeprom_get(0, print_arr, 8);
	push	#0x08
	push	#0x00
	ldw	x, sp
	addw	x, #11
	pushw	x
	clrw	x
	call	_eeprom_get
;	src/main.c: 51: for(int j = 0; j< sizeof(print_arr); ++j)
	clrw	x
	ldw	(0x1b, sp), x
00117$:
	ldw	x, (0x1b, sp)
	cpw	x, #0x0010
	jrsge	00108$
;	src/main.c: 53: printf("%02X", print_arr[j]);
	ldw	x, sp
	addw	x, #9
	addw	x, (0x1b, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	pushw	x
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	call	_printf
	addw	sp, #4
;	src/main.c: 51: for(int j = 0; j< sizeof(print_arr); ++j)
	ldw	x, (0x1b, sp)
	incw	x
	ldw	(0x1b, sp), x
	jra	00117$
00108$:
;	src/main.c: 55: printf("\r\n");
	ldw	x, #(___str_2+0)
	call	_puts
;	src/main.c: 56: while (1)
00111$:
;	src/main.c: 58: printf("UID: ");
	push	#<(___str_3+0)
	push	#((___str_3+0) >> 8)
	call	_printf
	addw	sp, #2
;	src/main.c: 59: for(int i = 0; i< 12; ++i)
	clrw	x
00120$:
	cpw	x, #0x000c
	jrsge	00109$
;	src/main.c: 61: printf("%02X", tmp_uid[i]);
	ldw	y, x
	addw	y, (0x19, sp)
	ld	a, (y)
	clr	(0x1b, sp)
	pushw	x
	push	a
	ld	a, (0x1e, sp)
	push	a
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	call	_printf
	addw	sp, #4
	popw	x
;	src/main.c: 59: for(int i = 0; i< 12; ++i)
	incw	x
	jra	00120$
00109$:
;	src/main.c: 63: printf("\r\n");
	ldw	x, #(___str_2+0)
	call	_puts
;	src/main.c: 64: ws2812_refresh();
	call	_ws2812_refresh
;	src/main.c: 66: faker_delay(100000);
	push	#0xa0
	push	#0x86
	push	#0x01
	push	#0x00
	call	_faker_delay
	jra	00111$
;	src/main.c: 68: }
	addw	sp, #28
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "%02X"
	.db 0x00
	.area CODE
	.area CONST
___str_2:
	.db 0x0d
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.ascii "UID: "
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
