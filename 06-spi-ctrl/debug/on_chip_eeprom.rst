                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module on_chip_eeprom
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _eeprom_get
                                     12 	.globl _eeprom_set
                                     13 	.globl _eeprom_dump
                                     14 	.globl ___memcpy
                                     15 	.globl _puts
                                     16 	.globl _printf
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	src/on_chip_eeprom.c: 15: void eeprom_dump(void)
                                     55 ;	-----------------------------------------
                                     56 ;	 function eeprom_dump
                                     57 ;	-----------------------------------------
      008208                         58 _eeprom_dump:
      008208 52 04            [ 2]   59 	sub	sp, #4
                                     60 ;	src/on_chip_eeprom.c: 17: for(int i = 0 ;i < EEPROM_LEN; ++i)
      00820A 5F               [ 1]   61 	clrw	x
      00820B 1F 03            [ 2]   62 	ldw	(0x03, sp), x
      00820D                         63 00106$:
      00820D 1E 03            [ 2]   64 	ldw	x, (0x03, sp)
      00820F A3 02 80         [ 2]   65 	cpw	x, #0x0280
      008212 24 3B            [ 1]   66 	jrnc	00104$
                                     67 ;	src/on_chip_eeprom.c: 19: if(i % 8  == 7)
      008214 4B 08            [ 1]   68 	push	#0x08
      008216 4B 00            [ 1]   69 	push	#0x00
      008218 1E 05            [ 2]   70 	ldw	x, (0x05, sp)
                                     71 ;	src/on_chip_eeprom.c: 21: printf("%02X\r\n", *((EEPROM_START_ADDR + i)));
      00821A CD 85 73         [ 4]   72 	call	__modsint
      00821D 16 03            [ 2]   73 	ldw	y, (0x03, sp)
      00821F 72 A9 40 00      [ 2]   74 	addw	y, #0x4000
      008223 90 F6            [ 1]   75 	ld	a, (y)
      008225 6B 02            [ 1]   76 	ld	(0x02, sp), a
      008227 0F 01            [ 1]   77 	clr	(0x01, sp)
                                     78 ;	src/on_chip_eeprom.c: 19: if(i % 8  == 7)
      008229 A3 00 07         [ 2]   79 	cpw	x, #0x0007
      00822C 26 0E            [ 1]   80 	jrne	00102$
                                     81 ;	src/on_chip_eeprom.c: 21: printf("%02X\r\n", *((EEPROM_START_ADDR + i)));
      00822E 1E 01            [ 2]   82 	ldw	x, (0x01, sp)
      008230 89               [ 2]   83 	pushw	x
      008231 4B 31            [ 1]   84 	push	#<(___str_0+0)
      008233 4B 80            [ 1]   85 	push	#((___str_0+0) >> 8)
      008235 CD 85 62         [ 4]   86 	call	_printf
      008238 5B 04            [ 2]   87 	addw	sp, #4
      00823A 20 0C            [ 2]   88 	jra	00107$
      00823C                         89 00102$:
                                     90 ;	src/on_chip_eeprom.c: 25: printf("%02X", (uint8_t)(*(EEPROM_START_ADDR + i)));
      00823C 1E 01            [ 2]   91 	ldw	x, (0x01, sp)
      00823E 89               [ 2]   92 	pushw	x
      00823F 4B 38            [ 1]   93 	push	#<(___str_1+0)
      008241 4B 80            [ 1]   94 	push	#((___str_1+0) >> 8)
      008243 CD 85 62         [ 4]   95 	call	_printf
      008246 5B 04            [ 2]   96 	addw	sp, #4
      008248                         97 00107$:
                                     98 ;	src/on_chip_eeprom.c: 17: for(int i = 0 ;i < EEPROM_LEN; ++i)
      008248 1E 03            [ 2]   99 	ldw	x, (0x03, sp)
      00824A 5C               [ 1]  100 	incw	x
      00824B 1F 03            [ 2]  101 	ldw	(0x03, sp), x
      00824D 20 BE            [ 2]  102 	jra	00106$
      00824F                        103 00104$:
                                    104 ;	src/on_chip_eeprom.c: 28: printf("\r\n");
      00824F AE 80 3D         [ 2]  105 	ldw	x, #(___str_3+0)
      008252 5B 04            [ 2]  106 	addw	sp, #4
                                    107 ;	src/on_chip_eeprom.c: 29: }
      008254 CC 85 2E         [ 2]  108 	jp	_puts
                                    109 ;	src/on_chip_eeprom.c: 31: void eeprom_set(uint16_t index, uint8_t * data, uint16_t len)
                                    110 ;	-----------------------------------------
                                    111 ;	 function eeprom_set
                                    112 ;	-----------------------------------------
      008257                        113 _eeprom_set:
      008257 52 06            [ 2]  114 	sub	sp, #6
                                    115 ;	src/on_chip_eeprom.c: 33: if(index + len > EEPROM_LEN)
      008259 1F 03            [ 2]  116 	ldw	(0x03, sp), x
      00825B 72 FB 0B         [ 2]  117 	addw	x, (0x0b, sp)
      00825E A3 02 80         [ 2]  118 	cpw	x, #0x0280
                                    119 ;	src/on_chip_eeprom.c: 35: return;
      008261 22 3F            [ 1]  120 	jrugt	00113$
                                    121 ;	src/on_chip_eeprom.c: 39: FLASH_BASE_ADDR->dukr = EEPROM_FIRST_HW_KEY;
      008263 35 AE 50 64      [ 1]  122 	mov	0x5064+0, #0xae
                                    123 ;	src/on_chip_eeprom.c: 40: FLASH_BASE_ADDR->dukr = EEPROM_SECOND_HW_KEY;
      008267 35 56 50 64      [ 1]  124 	mov	0x5064+0, #0x56
                                    125 ;	src/on_chip_eeprom.c: 41: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_DUL_MASK));
      00826B                        126 00103$:
      00826B C6 50 5F         [ 1]  127 	ld	a, 0x505f
      00826E A5 08            [ 1]  128 	bcp	a, #0x08
      008270 27 F9            [ 1]  129 	jreq	00103$
                                    130 ;	src/on_chip_eeprom.c: 44: for(int i = 0; i<len; ++i)
      008272 1E 03            [ 2]  131 	ldw	x, (0x03, sp)
      008274 1C 40 00         [ 2]  132 	addw	x, #0x4000
      008277 1F 01            [ 2]  133 	ldw	(0x01, sp), x
      008279 5F               [ 1]  134 	clrw	x
      00827A 1F 05            [ 2]  135 	ldw	(0x05, sp), x
      00827C                        136 00111$:
      00827C 1E 05            [ 2]  137 	ldw	x, (0x05, sp)
      00827E 13 0B            [ 2]  138 	cpw	x, (0x0b, sp)
      008280 24 1B            [ 1]  139 	jrnc	00109$
                                    140 ;	src/on_chip_eeprom.c: 46: (*(volatile uint8_t *)(EEPROM_START_ADDR + index + i)) = data[i];
      008282 1E 01            [ 2]  141 	ldw	x, (0x01, sp)
      008284 72 FB 05         [ 2]  142 	addw	x, (0x05, sp)
      008287 16 09            [ 2]  143 	ldw	y, (0x09, sp)
      008289 72 F9 05         [ 2]  144 	addw	y, (0x05, sp)
      00828C 90 F6            [ 1]  145 	ld	a, (y)
      00828E F7               [ 1]  146 	ld	(x), a
                                    147 ;	src/on_chip_eeprom.c: 47: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
      00828F                        148 00106$:
                                    149 ;	src/on_chip_eeprom.c: 41: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_DUL_MASK));
      00828F C6 50 5F         [ 1]  150 	ld	a, 0x505f
                                    151 ;	src/on_chip_eeprom.c: 47: while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
      008292 A5 04            [ 1]  152 	bcp	a, #0x04
      008294 27 F9            [ 1]  153 	jreq	00106$
                                    154 ;	src/on_chip_eeprom.c: 44: for(int i = 0; i<len; ++i)
      008296 1E 05            [ 2]  155 	ldw	x, (0x05, sp)
      008298 5C               [ 1]  156 	incw	x
      008299 1F 05            [ 2]  157 	ldw	(0x05, sp), x
      00829B 20 DF            [ 2]  158 	jra	00111$
      00829D                        159 00109$:
                                    160 ;	src/on_chip_eeprom.c: 50: FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_DUL_MASK);
      00829D A4 F7            [ 1]  161 	and	a, #0xf7
      00829F C7 50 5F         [ 1]  162 	ld	0x505f, a
      0082A2                        163 00113$:
                                    164 ;	src/on_chip_eeprom.c: 51: }
      0082A2 1E 07            [ 2]  165 	ldw	x, (7, sp)
      0082A4 5B 0C            [ 2]  166 	addw	sp, #12
      0082A6 FC               [ 2]  167 	jp	(x)
                                    168 ;	src/on_chip_eeprom.c: 53: void eeprom_get(uint16_t index, uint8_t * buffer, uint16_t len)
                                    169 ;	-----------------------------------------
                                    170 ;	 function eeprom_get
                                    171 ;	-----------------------------------------
      0082A7                        172 _eeprom_get:
      0082A7 52 02            [ 2]  173 	sub	sp, #2
                                    174 ;	src/on_chip_eeprom.c: 55: memcpy(buffer, (volatile uint8_t *)(EEPROM_START_ADDR + index), len);
      0082A9 16 07            [ 2]  175 	ldw	y, (0x07, sp)
      0082AB 1C 40 00         [ 2]  176 	addw	x, #0x4000
      0082AE 1F 01            [ 2]  177 	ldw	(0x01, sp), x
      0082B0 1E 05            [ 2]  178 	ldw	x, (0x05, sp)
      0082B2 90 89            [ 2]  179 	pushw	y
      0082B4 16 03            [ 2]  180 	ldw	y, (0x03, sp)
      0082B6 90 89            [ 2]  181 	pushw	y
      0082B8 CD 84 DB         [ 4]  182 	call	___memcpy
                                    183 ;	src/on_chip_eeprom.c: 56: }
      0082BB 1E 03            [ 2]  184 	ldw	x, (3, sp)
      0082BD 5B 08            [ 2]  185 	addw	sp, #8
      0082BF FC               [ 2]  186 	jp	(x)
                                    187 	.area CODE
                                    188 	.area CONST
                                    189 	.area CONST
      008031                        190 ___str_0:
      008031 25 30 32 58            191 	.ascii "%02X"
      008035 0D                     192 	.db 0x0d
      008036 0A                     193 	.db 0x0a
      008037 00                     194 	.db 0x00
                                    195 	.area CODE
                                    196 	.area CONST
      008038                        197 ___str_1:
      008038 25 30 32 58            198 	.ascii "%02X"
      00803C 00                     199 	.db 0x00
                                    200 	.area CODE
                                    201 	.area CONST
      00803D                        202 ___str_3:
      00803D 0D                     203 	.db 0x0d
      00803E 00                     204 	.db 0x00
                                    205 	.area CODE
                                    206 	.area INITIALIZER
                                    207 	.area CABS (ABS)
