;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module on_board_led
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _on_board_led_blink
	.globl _on_board_led_init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
;	src/on_board_led.c: 4: void on_board_led_init()
;	-----------------------------------------
;	 function on_board_led_init
;	-----------------------------------------
_on_board_led_init:
;	src/on_board_led.c: 6: GPIO_B_BASE_ADDR->DDR |= (1 << 5);
	bset	0x5007, #5
;	src/on_board_led.c: 7: GPIO_B_BASE_ADDR->CR1 |= (1 << 5);
	bset	0x5008, #5
;	src/on_board_led.c: 8: }
	ret
;	src/on_board_led.c: 10: void on_board_led_blink()
;	-----------------------------------------
;	 function on_board_led_blink
;	-----------------------------------------
_on_board_led_blink:
;	src/on_board_led.c: 12: GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
	bcpl	0x5005, #5
;	src/on_board_led.c: 13: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
