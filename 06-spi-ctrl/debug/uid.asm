;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module uid
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _get_uid
	.globl ___memcpy
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_gs_uid_buffer:
	.ds 12
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
;	src/uid.c: 8: uint8_t * get_uid(void)
;	-----------------------------------------
;	 function get_uid
;	-----------------------------------------
_get_uid:
;	src/uid.c: 10: memcpy(gs_uid_buffer, UID_START_ADDR, UID_LEN);
	push	#0x0c
	push	#0x00
	push	#0x65
	push	#0x48
	ldw	x, #(_gs_uid_buffer+0)
	call	___memcpy
;	src/uid.c: 11: return gs_uid_buffer;
	ldw	x, #(_gs_uid_buffer+0)
;	src/uid.c: 12: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__gs_uid_buffer:
	.db #0x00	; 0
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
