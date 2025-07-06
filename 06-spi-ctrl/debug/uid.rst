                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module uid
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _get_uid
                                     12 	.globl ___memcpy
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
      000001                         21 _gs_uid_buffer:
      000001                         22 	.ds 12
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DABS (ABS)
                                     27 
                                     28 ; default segment ordering for linker
                                     29 	.area HOME
                                     30 	.area GSINIT
                                     31 	.area GSFINAL
                                     32 	.area CONST
                                     33 	.area INITIALIZER
                                     34 	.area CODE
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; global & static initialisations
                                     38 ;--------------------------------------------------------
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area GSINIT
                                     43 ;--------------------------------------------------------
                                     44 ; Home
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
                                     47 	.area HOME
                                     48 ;--------------------------------------------------------
                                     49 ; code
                                     50 ;--------------------------------------------------------
                                     51 	.area CODE
                                     52 ;	src/uid.c: 8: uint8_t * get_uid(void)
                                     53 ;	-----------------------------------------
                                     54 ;	 function get_uid
                                     55 ;	-----------------------------------------
      008349                         56 _get_uid:
                                     57 ;	src/uid.c: 10: memcpy(gs_uid_buffer, UID_START_ADDR, UID_LEN);
      008349 4B 0C            [ 1]   58 	push	#0x0c
      00834B 4B 00            [ 1]   59 	push	#0x00
      00834D 4B 65            [ 1]   60 	push	#0x65
      00834F 4B 48            [ 1]   61 	push	#0x48
      008351 AE 00 01         [ 2]   62 	ldw	x, #(_gs_uid_buffer+0)
      008354 CD 84 DB         [ 4]   63 	call	___memcpy
                                     64 ;	src/uid.c: 11: return gs_uid_buffer;
      008357 AE 00 01         [ 2]   65 	ldw	x, #(_gs_uid_buffer+0)
                                     66 ;	src/uid.c: 12: }
      00835A 81               [ 4]   67 	ret
                                     68 	.area CODE
                                     69 	.area CONST
                                     70 	.area INITIALIZER
      00804A                         71 __xinit__gs_uid_buffer:
      00804A 00                      72 	.db #0x00	; 0
      00804B 00                      73 	.db 0x00
      00804C 00                      74 	.db 0x00
      00804D 00                      75 	.db 0x00
      00804E 00                      76 	.db 0x00
      00804F 00                      77 	.db 0x00
      008050 00                      78 	.db 0x00
      008051 00                      79 	.db 0x00
      008052 00                      80 	.db 0x00
      008053 00                      81 	.db 0x00
      008054 00                      82 	.db 0x00
      008055 00                      83 	.db 0x00
                                     84 	.area CABS (ABS)
