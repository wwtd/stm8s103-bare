;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module on_chip_eeprom
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _eeprom_get
	.globl _eeprom_set
	.globl _eeprom_dump
	.globl ___memcpy
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
;	src/on_chip_eeprom.c: 15: void eeprom_dump(void)
;	-----------------------------------------
;	 function eeprom_dump
;	-----------------------------------------
_eeprom_dump:
	sub	sp, #4
;	src/on_chip_eeprom.c: 17: for(int i = 0 ;i < EEPROM_LEN; ++i)
	clrw	x
	ldw	(0x03, sp), x
00106$:
	ldw	x, (0x03, sp)
	cpw	x, #0x0280
	jrnc	00104$
;	src/on_chip_eeprom.c: 19: if(i % 8  == 7)
	push	#0x08
	push	#0x00
	ldw	x, (0x05, sp)
;	src/on_chip_eeprom.c: 21: printf("%02X\r\n", *((EEPROM_START_ADDR + i)));
	call	__modsint
	ldw	y, (0x03, sp)
	addw	y, #0x4000
	ld	a, (y)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	src/on_chip_eeprom.c: 19: if(i % 8  == 7)
	cpw	x, #0x0007
	jrne	00102$
;	src/on_chip_eeprom.c: 21: printf("%02X\r\n", *((EEPROM_START_ADDR + i)));
	ldw	x, (0x01, sp)
	pushw	x
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	call	_printf
	addw	sp, #4
	jra	00107$
00102$:
;	src/on_chip_eeprom.c: 25: printf("%02X", (uint8_t)(*(EEPROM_START_ADDR + i)));
	ldw	x, (0x01, sp)
	pushw	x
	push	#<(___str_1+0)
	push	#((___str_1+0) >> 8)
	call	_printf
	addw	sp, #4
00107$:
;	src/on_chip_eeprom.c: 17: for(int i = 0 ;i < EEPROM_LEN; ++i)
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00106$
00104$:
;	src/on_chip_eeprom.c: 28: printf("\r\n");
	ldw	x, #(___str_3+0)
	addw	sp, #4
;	src/on_chip_eeprom.c: 29: }
	jp	_puts
;	src/on_chip_eeprom.c: 31: void eeprom_set(uint16_t index, uint8_t * data, uint16_t len)
;	-----------------------------------------
;	 function eeprom_set
;	-----------------------------------------
_eeprom_set:
	sub	sp, #6
;	src/on_chip_eeprom.c: 33: if(index + len > EEPROM_LEN)
	ldw	(0x03, sp), x
	addw	x, (0x0b, sp)
	cpw	x, #0x0280
;	src/on_chip_eeprom.c: 35: return;
	jrugt	00113$
;	src/on_chip_eeprom.c: 39: FLASH_BASE_ADDR->dukr = EEPROM_FIRST_HW_KEY;
	mov	0x5064+0, #0xae
;	src/on_chip_eeprom.c: 40: FLASH_BASE_ADDR->dukr = EEPROM_SECOND_HW_KEY;
	mov	0x5064+0, #0x56
;	src/on_chip_eeprom.c: 41: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_DUL_MASK));
00103$:
	ld	a, 0x505f
	bcp	a, #0x08
	jreq	00103$
;	src/on_chip_eeprom.c: 44: for(int i = 0; i<len; ++i)
	ldw	x, (0x03, sp)
	addw	x, #0x4000
	ldw	(0x01, sp), x
	clrw	x
	ldw	(0x05, sp), x
00111$:
	ldw	x, (0x05, sp)
	cpw	x, (0x0b, sp)
	jrnc	00109$
;	src/on_chip_eeprom.c: 46: (*(volatile uint8_t *)(EEPROM_START_ADDR + index + i)) = data[i];
	ldw	x, (0x01, sp)
	addw	x, (0x05, sp)
	ldw	y, (0x09, sp)
	addw	y, (0x05, sp)
	ld	a, (y)
	ld	(x), a
;	src/on_chip_eeprom.c: 47: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
00106$:
;	src/on_chip_eeprom.c: 41: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_DUL_MASK));
	ld	a, 0x505f
;	src/on_chip_eeprom.c: 47: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
	bcp	a, #0x04
	jreq	00106$
;	src/on_chip_eeprom.c: 44: for(int i = 0; i<len; ++i)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jra	00111$
00109$:
;	src/on_chip_eeprom.c: 50: FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_DUL_MASK);
	and	a, #0xf7
	ld	0x505f, a
00113$:
;	src/on_chip_eeprom.c: 51: }
	ldw	x, (7, sp)
	addw	sp, #12
	jp	(x)
;	src/on_chip_eeprom.c: 53: void eeprom_get(uint16_t index, uint8_t * buffer, uint16_t len)
;	-----------------------------------------
;	 function eeprom_get
;	-----------------------------------------
_eeprom_get:
	sub	sp, #2
;	src/on_chip_eeprom.c: 55: memcpy(buffer, (volatile uint8_t *)(EEPROM_START_ADDR + index), len);
	ldw	y, (0x07, sp)
	addw	x, #0x4000
	ldw	(0x01, sp), x
	ldw	x, (0x05, sp)
	pushw	y
	ldw	y, (0x03, sp)
	pushw	y
	call	___memcpy
;	src/on_chip_eeprom.c: 56: }
	ldw	x, (3, sp)
	addw	sp, #8
	jp	(x)
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "%02X"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "%02X"
	.db 0x00
	.area CODE
	.area CONST
___str_3:
	.db 0x0d
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
