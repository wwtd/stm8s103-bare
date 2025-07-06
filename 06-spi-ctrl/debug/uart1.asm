;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module uart1
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putchar
	.globl _uart1_send_char
	.globl _uart1_init
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
;	src/uart1.c: 6: void uart1_init()
;	-----------------------------------------
;	 function uart1_init
;	-----------------------------------------
_uart1_init:
;	src/uart1.c: 8: CLK_BASE_ADDR->PCKENR1 |= (1 << 3);
	bset	0x50c7, #3
;	src/uart1.c: 9: UART_1_BASE_ADDR->BRR2 = 0x0A;
	mov	0x5233+0, #0x0a
;	src/uart1.c: 10: UART_1_BASE_ADDR->BRR1 = 0x08;
	mov	0x5232+0, #0x08
;	src/uart1.c: 11: UART_1_BASE_ADDR->CR2 = ((1<<2)|(1<<3));
	mov	0x5235+0, #0x0c
;	src/uart1.c: 12: }
	ret
;	src/uart1.c: 14: void uart1_send_char(const char ch)
;	-----------------------------------------
;	 function uart1_send_char
;	-----------------------------------------
_uart1_send_char:
;	src/uart1.c: 16: UART_1_BASE_ADDR->DR = ch;
	ld	0x5231, a
;	src/uart1.c: 17: while(!(UART_1_BASE_ADDR->SR & (1<<6)));
00101$:
	btjf	0x5230, #6, 00101$
;	src/uart1.c: 18: }
	ret
;	src/uart1.c: 20: int putchar(int ch)
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	ld	a, xl
;	src/uart1.c: 22: uart1_send_char(ch);
	call	_uart1_send_char
;	src/uart1.c: 23: return 0;
	clrw	x
;	src/uart1.c: 24: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
