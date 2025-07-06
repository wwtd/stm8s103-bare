;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module clk_ctrl
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _enable_HSI_16MHz
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
;	src/clk_ctrl.c: 4: void enable_HSI_16MHz(void)
;	-----------------------------------------
;	 function enable_HSI_16MHz
;	-----------------------------------------
_enable_HSI_16MHz:
;	src/clk_ctrl.c: 7: CLK_BASE_ADDR->ICKR |= (1 << 0); // HSIEN = 1
	bset	0x50c0, #0
;	src/clk_ctrl.c: 10: while ((CLK_BASE_ADDR->ICKR & (1 << 1)) == 0); // HSIRDY = 1
00101$:
	btjf	0x50c0, #1, 00101$
;	src/clk_ctrl.c: 13: CLK_BASE_ADDR->SWR = 0x01; // SW[2:0] = 001 => HSI
	mov	0x50c4+0, #0x01
;	src/clk_ctrl.c: 16: while ((CLK_BASE_ADDR->CMSR & 0x07) != 0x01);
00104$:
	ld	a, 0x50c3
	and	a, #0x07
	ld	xl, a
	clr	a
	ld	xh, a
	decw	x
	jrne	00104$
;	src/clk_ctrl.c: 19: CLK_BASE_ADDR->CKDIVR = 0x00; // HSIDIV = 1, CPUDIV = 1
	mov	0x50c6+0, #0x00
;	src/clk_ctrl.c: 22: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
