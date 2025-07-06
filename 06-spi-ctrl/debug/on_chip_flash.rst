                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module on_chip_flash
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _flash_get
                                     12 	.globl _flash_set
                                     13 	.globl ___memcpy
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	src/on_chip_flash.c: 13: void flash_set(uint16_t index, uint8_t * data, uint16_t len)
                                     52 ;	-----------------------------------------
                                     53 ;	 function flash_set
                                     54 ;	-----------------------------------------
      0082C0                         55 _flash_set:
      0082C0 52 06            [ 2]   56 	sub	sp, #6
                                     57 ;	src/on_chip_flash.c: 15: if(index + len > FLASH_LEN)
      0082C2 1F 03            [ 2]   58 	ldw	(0x03, sp), x
      0082C4 72 FB 0B         [ 2]   59 	addw	x, (0x0b, sp)
      0082C7 A3 1F 80         [ 2]   60 	cpw	x, #0x1f80
                                     61 ;	src/on_chip_flash.c: 17: return;
      0082CA 22 3F            [ 1]   62 	jrugt	00113$
                                     63 ;	src/on_chip_flash.c: 21: FLASH_BASE_ADDR->dukr = FLASH_FIRST_HW_KEY;
      0082CC 35 AE 50 64      [ 1]   64 	mov	0x5064+0, #0xae
                                     65 ;	src/on_chip_flash.c: 22: FLASH_BASE_ADDR->dukr = FLASH_SECOND_HW_KEY;
      0082D0 35 56 50 64      [ 1]   66 	mov	0x5064+0, #0x56
                                     67 ;	src/on_chip_flash.c: 23: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_PUL_MASK));
      0082D4                         68 00103$:
      0082D4 C6 50 5F         [ 1]   69 	ld	a, 0x505f
      0082D7 A5 02            [ 1]   70 	bcp	a, #0x02
      0082D9 27 F9            [ 1]   71 	jreq	00103$
                                     72 ;	src/on_chip_flash.c: 26: for(int i = 0; i<len; ++i)
      0082DB 1E 03            [ 2]   73 	ldw	x, (0x03, sp)
      0082DD 1C 80 7F         [ 2]   74 	addw	x, #0x807f
      0082E0 1F 01            [ 2]   75 	ldw	(0x01, sp), x
      0082E2 5F               [ 1]   76 	clrw	x
      0082E3 1F 05            [ 2]   77 	ldw	(0x05, sp), x
      0082E5                         78 00111$:
      0082E5 1E 05            [ 2]   79 	ldw	x, (0x05, sp)
      0082E7 13 0B            [ 2]   80 	cpw	x, (0x0b, sp)
      0082E9 24 1B            [ 1]   81 	jrnc	00109$
                                     82 ;	src/on_chip_flash.c: 28: (*(volatile uint8_t *)(FLASH_START_ADDR + index + i)) = data[i];
      0082EB 1E 01            [ 2]   83 	ldw	x, (0x01, sp)
      0082ED 72 FB 05         [ 2]   84 	addw	x, (0x05, sp)
      0082F0 16 09            [ 2]   85 	ldw	y, (0x09, sp)
      0082F2 72 F9 05         [ 2]   86 	addw	y, (0x05, sp)
      0082F5 90 F6            [ 1]   87 	ld	a, (y)
      0082F7 F7               [ 1]   88 	ld	(x), a
                                     89 ;	src/on_chip_flash.c: 29: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
      0082F8                         90 00106$:
                                     91 ;	src/on_chip_flash.c: 23: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_PUL_MASK));
      0082F8 C6 50 5F         [ 1]   92 	ld	a, 0x505f
                                     93 ;	src/on_chip_flash.c: 29: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
      0082FB A5 04            [ 1]   94 	bcp	a, #0x04
      0082FD 27 F9            [ 1]   95 	jreq	00106$
                                     96 ;	src/on_chip_flash.c: 26: for(int i = 0; i<len; ++i)
      0082FF 1E 05            [ 2]   97 	ldw	x, (0x05, sp)
      008301 5C               [ 1]   98 	incw	x
      008302 1F 05            [ 2]   99 	ldw	(0x05, sp), x
      008304 20 DF            [ 2]  100 	jra	00111$
      008306                        101 00109$:
                                    102 ;	src/on_chip_flash.c: 32: FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_PUL_MASK);
      008306 A4 FD            [ 1]  103 	and	a, #0xfd
      008308 C7 50 5F         [ 1]  104 	ld	0x505f, a
      00830B                        105 00113$:
                                    106 ;	src/on_chip_flash.c: 33: }
      00830B 1E 07            [ 2]  107 	ldw	x, (7, sp)
      00830D 5B 0C            [ 2]  108 	addw	sp, #12
      00830F FC               [ 2]  109 	jp	(x)
                                    110 ;	src/on_chip_flash.c: 35: void flash_get(uint16_t index, uint8_t * buffer, uint16_t len)
                                    111 ;	-----------------------------------------
                                    112 ;	 function flash_get
                                    113 ;	-----------------------------------------
      008310                        114 _flash_get:
      008310 52 02            [ 2]  115 	sub	sp, #2
                                    116 ;	src/on_chip_flash.c: 37: memcpy(buffer, (volatile uint8_t *)(FLASH_START_ADDR + index), len);
      008312 16 07            [ 2]  117 	ldw	y, (0x07, sp)
      008314 1C 80 7F         [ 2]  118 	addw	x, #0x807f
      008317 1F 01            [ 2]  119 	ldw	(0x01, sp), x
      008319 1E 05            [ 2]  120 	ldw	x, (0x05, sp)
      00831B 90 89            [ 2]  121 	pushw	y
      00831D 16 03            [ 2]  122 	ldw	y, (0x03, sp)
      00831F 90 89            [ 2]  123 	pushw	y
      008321 CD 84 DB         [ 4]  124 	call	___memcpy
                                    125 ;	src/on_chip_flash.c: 38: }
      008324 1E 03            [ 2]  126 	ldw	x, (3, sp)
      008326 5B 08            [ 2]  127 	addw	sp, #8
      008328 FC               [ 2]  128 	jp	(x)
                                    129 	.area CODE
                                    130 	.area CONST
                                    131 	.area INITIALIZER
                                    132 	.area CABS (ABS)
