;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module on_chip_flash
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _flash_get
	.globl _flash_set
	.globl ___memcpy
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
;	src/on_chip_flash.c: 13: void flash_set(uint16_t index, uint8_t * data, uint16_t len)
;	-----------------------------------------
;	 function flash_set
;	-----------------------------------------
_flash_set:
	sub	sp, #6
;	src/on_chip_flash.c: 15: if(index + len > FLASH_LEN)
	ldw	(0x03, sp), x
	addw	x, (0x0b, sp)
	cpw	x, #0x1f80
;	src/on_chip_flash.c: 17: return;
	jrugt	00113$
;	src/on_chip_flash.c: 21: FLASH_BASE_ADDR->dukr = FLASH_FIRST_HW_KEY;
	mov	0x5064+0, #0xae
;	src/on_chip_flash.c: 22: FLASH_BASE_ADDR->dukr = FLASH_SECOND_HW_KEY;
	mov	0x5064+0, #0x56
;	src/on_chip_flash.c: 23: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_PUL_MASK));
00103$:
	ld	a, 0x505f
	bcp	a, #0x02
	jreq	00103$
;	src/on_chip_flash.c: 26: for(int i = 0; i<len; ++i)
	ldw	x, (0x03, sp)
	addw	x, #0x807f
	ldw	(0x01, sp), x
	clrw	x
	ldw	(0x05, sp), x
00111$:
	ldw	x, (0x05, sp)
	cpw	x, (0x0b, sp)
	jrnc	00109$
;	src/on_chip_flash.c: 28: (*(volatile uint8_t *)(FLASH_START_ADDR + index + i)) = data[i];
	ldw	x, (0x01, sp)
	addw	x, (0x05, sp)
	ldw	y, (0x09, sp)
	addw	y, (0x05, sp)
	ld	a, (y)
	ld	(x), a
;	src/on_chip_flash.c: 29: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
00106$:
;	src/on_chip_flash.c: 23: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_PUL_MASK));
	ld	a, 0x505f
;	src/on_chip_flash.c: 29: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
	bcp	a, #0x04
	jreq	00106$
;	src/on_chip_flash.c: 26: for(int i = 0; i<len; ++i)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jra	00111$
00109$:
;	src/on_chip_flash.c: 32: FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_PUL_MASK);
	and	a, #0xfd
	ld	0x505f, a
00113$:
;	src/on_chip_flash.c: 33: }
	ldw	x, (7, sp)
	addw	sp, #12
	jp	(x)
;	src/on_chip_flash.c: 35: void flash_get(uint16_t index, uint8_t * buffer, uint16_t len)
;	-----------------------------------------
;	 function flash_get
;	-----------------------------------------
_flash_get:
	sub	sp, #2
;	src/on_chip_flash.c: 37: memcpy(buffer, (volatile uint8_t *)(FLASH_START_ADDR + index), len);
	ldw	y, (0x07, sp)
	addw	x, #0x807f
	ldw	(0x01, sp), x
	ldw	x, (0x05, sp)
	pushw	y
	ldw	y, (0x03, sp)
	pushw	y
	call	___memcpy
;	src/on_chip_flash.c: 38: }
	ldw	x, (3, sp)
	addw	sp, #8
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
