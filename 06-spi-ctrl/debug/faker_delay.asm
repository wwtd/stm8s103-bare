;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module faker_delay
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _faker_delay
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
;	src/faker_delay.c: 3: void faker_delay(uint32_t cnt)
;	-----------------------------------------
;	 function faker_delay
;	-----------------------------------------
_faker_delay:
	sub	sp, #4
;	src/faker_delay.c: 5: for (volatile uint32_t i = 0; i < cnt; ++i);
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
00103$:
	ldw	x, (0x03, sp)
	cpw	x, (0x09, sp)
	ld	a, (0x02, sp)
	sbc	a, (0x08, sp)
	ld	a, (0x01, sp)
	sbc	a, (0x07, sp)
	jrnc	00105$
	ldw	x, (0x03, sp)
	addw	x, #0x0001
	ldw	y, (0x01, sp)
	jrnc	00118$
	incw	y
00118$:
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00103$
00105$:
;	src/faker_delay.c: 6: }
	ldw	x, (5, sp)
	addw	sp, #10
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
