                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _eeprom_get
                                     13 	.globl _eeprom_set
                                     14 	.globl _get_uid
                                     15 	.globl _ws2812_set_one_color
                                     16 	.globl _ws2812_refresh
                                     17 	.globl _ws2812_init
                                     18 	.globl _on_board_led_init
                                     19 	.globl _enable_HSI_16MHz
                                     20 	.globl _uart1_init
                                     21 	.globl _faker_delay
                                     22 	.globl _puts
                                     23 	.globl _printf
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DATA
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area INITIALIZED
                                     32 ;--------------------------------------------------------
                                     33 ; Stack segment in internal ram
                                     34 ;--------------------------------------------------------
                                     35 	.area	SSEG
      008BA5                         36 __start__stack:
      008BA5                         37 	.ds	1
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; absolute external ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area DABS (ABS)
                                     43 
                                     44 ; default segment ordering for linker
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area CONST
                                     49 	.area INITIALIZER
                                     50 	.area CODE
                                     51 
                                     52 ;--------------------------------------------------------
                                     53 ; interrupt vector
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
      008000                         56 __interrupt_vect:
      008000 82 00 80 07             57 	int s_GSINIT ; reset
                                     58 ;--------------------------------------------------------
                                     59 ; global & static initialisations
                                     60 ;--------------------------------------------------------
                                     61 	.area HOME
                                     62 	.area GSINIT
                                     63 	.area GSFINAL
                                     64 	.area GSINIT
      008007                         65 __sdcc_init_data:
                                     66 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   67 	ldw x, #l_DATA
      00800A 27 07            [ 1]   68 	jreq	00002$
      00800C                         69 00001$:
      00800C 72 4F 00 00      [ 1]   70 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   71 	decw x
      008011 26 F9            [ 1]   72 	jrne	00001$
      008013                         73 00002$:
      008013 AE 00 4C         [ 2]   74 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   75 	jreq	00004$
      008018                         76 00003$:
      008018 D6 80 49         [ 1]   77 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   78 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   79 	decw	x
      00801F 26 F7            [ 1]   80 	jrne	00003$
      008021                         81 00004$:
                                     82 ; stm8_genXINIT() end
                                     83 	.area GSFINAL
      008021 CC 80 04         [ 2]   84 	jp	__sdcc_program_startup
                                     85 ;--------------------------------------------------------
                                     86 ; Home
                                     87 ;--------------------------------------------------------
                                     88 	.area HOME
                                     89 	.area HOME
      008004                         90 __sdcc_program_startup:
      008004 CC 80 DE         [ 2]   91 	jp	_main
                                     92 ;	return from main will return to caller
                                     93 ;--------------------------------------------------------
                                     94 ; code
                                     95 ;--------------------------------------------------------
                                     96 	.area CODE
                                     97 ;	src/main.c: 22: void main()
                                     98 ;	-----------------------------------------
                                     99 ;	 function main
                                    100 ;	-----------------------------------------
      0080DE                        101 _main:
      0080DE 52 1C            [ 2]  102 	sub	sp, #28
                                    103 ;	src/main.c: 24: enable_HSI_16MHz();
      0080E0 CD 80 96         [ 4]  104 	call	_enable_HSI_16MHz
                                    105 ;	src/main.c: 25: on_board_led_init();
      0080E3 CD 81 FA         [ 4]  106 	call	_on_board_led_init
                                    107 ;	src/main.c: 26: uart1_init();
      0080E6 CD 83 29         [ 4]  108 	call	_uart1_init
                                    109 ;	src/main.c: 27: ws2812_init();
      0080E9 CD 83 5B         [ 4]  110 	call	_ws2812_init
                                    111 ;	src/main.c: 29: for(int i = 0; i < 16; ++i)
      0080EC 5F               [ 1]  112 	clrw	x
      0080ED 1F 1B            [ 2]  113 	ldw	(0x1b, sp), x
      0080EF                        114 00114$:
      0080EF 1E 1B            [ 2]  115 	ldw	x, (0x1b, sp)
      0080F1 A3 00 10         [ 2]  116 	cpw	x, #0x0010
      0080F4 2E 3A            [ 1]  117 	jrsge	00107$
                                    118 ;	src/main.c: 31: if(i%3 == 0)
      0080F6 4B 03            [ 1]  119 	push	#0x03
      0080F8 4B 00            [ 1]  120 	push	#0x00
      0080FA 1E 1D            [ 2]  121 	ldw	x, (0x1d, sp)
                                    122 ;	src/main.c: 33: ws2812_set_one_color(i, 0xFF);
      0080FC CD 85 73         [ 4]  123 	call	__modsint
      0080FF 16 1B            [ 2]  124 	ldw	y, (0x1b, sp)
                                    125 ;	src/main.c: 31: if(i%3 == 0)
      008101 5D               [ 2]  126 	tnzw	x
      008102 26 0C            [ 1]  127 	jrne	00105$
                                    128 ;	src/main.c: 33: ws2812_set_one_color(i, 0xFF);
      008104 4B FF            [ 1]  129 	push	#0xff
      008106 5F               [ 1]  130 	clrw	x
      008107 89               [ 2]  131 	pushw	x
      008108 4B 00            [ 1]  132 	push	#0x00
      00810A 93               [ 1]  133 	ldw	x, y
      00810B CD 84 BE         [ 4]  134 	call	_ws2812_set_one_color
      00810E 20 19            [ 2]  135 	jra	00115$
      008110                        136 00105$:
                                    137 ;	src/main.c: 35: else if(i%3 == 1)
      008110 5A               [ 2]  138 	decw	x
      008111 26 0C            [ 1]  139 	jrne	00102$
                                    140 ;	src/main.c: 37: ws2812_set_one_color(i, 0xFF00);
      008113 4B 00            [ 1]  141 	push	#0x00
      008115 4B FF            [ 1]  142 	push	#0xff
      008117 5F               [ 1]  143 	clrw	x
      008118 89               [ 2]  144 	pushw	x
      008119 93               [ 1]  145 	ldw	x, y
      00811A CD 84 BE         [ 4]  146 	call	_ws2812_set_one_color
      00811D 20 0A            [ 2]  147 	jra	00115$
      00811F                        148 00102$:
                                    149 ;	src/main.c: 41: ws2812_set_one_color(i, 0xFF0000);
      00811F 5F               [ 1]  150 	clrw	x
      008120 89               [ 2]  151 	pushw	x
      008121 4B FF            [ 1]  152 	push	#0xff
      008123 4B 00            [ 1]  153 	push	#0x00
      008125 93               [ 1]  154 	ldw	x, y
      008126 CD 84 BE         [ 4]  155 	call	_ws2812_set_one_color
      008129                        156 00115$:
                                    157 ;	src/main.c: 29: for(int i = 0; i < 16; ++i)
      008129 1E 1B            [ 2]  158 	ldw	x, (0x1b, sp)
      00812B 5C               [ 1]  159 	incw	x
      00812C 1F 1B            [ 2]  160 	ldw	(0x1b, sp), x
      00812E 20 BF            [ 2]  161 	jra	00114$
      008130                        162 00107$:
                                    163 ;	src/main.c: 45: uint8_t * tmp_uid = get_uid();
      008130 CD 83 49         [ 4]  164 	call	_get_uid
      008133 1F 19            [ 2]  165 	ldw	(0x19, sp), x
                                    166 ;	src/main.c: 47: uint8_t test_arr[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
      008135 96               [ 1]  167 	ldw	x, sp
      008136 5C               [ 1]  168 	incw	x
      008137 A6 01            [ 1]  169 	ld	a, #0x01
      008139 F7               [ 1]  170 	ld	(x), a
      00813A A6 02            [ 1]  171 	ld	a, #0x02
      00813C 6B 02            [ 1]  172 	ld	(0x02, sp), a
      00813E A6 03            [ 1]  173 	ld	a, #0x03
      008140 6B 03            [ 1]  174 	ld	(0x03, sp), a
      008142 A6 04            [ 1]  175 	ld	a, #0x04
      008144 6B 04            [ 1]  176 	ld	(0x04, sp), a
      008146 A6 05            [ 1]  177 	ld	a, #0x05
      008148 6B 05            [ 1]  178 	ld	(0x05, sp), a
      00814A A6 06            [ 1]  179 	ld	a, #0x06
      00814C 6B 06            [ 1]  180 	ld	(0x06, sp), a
      00814E A6 07            [ 1]  181 	ld	a, #0x07
      008150 6B 07            [ 1]  182 	ld	(0x07, sp), a
      008152 A6 08            [ 1]  183 	ld	a, #0x08
      008154 6B 08            [ 1]  184 	ld	(0x08, sp), a
                                    185 ;	src/main.c: 48: eeprom_set(0, test_arr, sizeof(test_arr));
      008156 4B 08            [ 1]  186 	push	#0x08
      008158 4B 00            [ 1]  187 	push	#0x00
      00815A 89               [ 2]  188 	pushw	x
      00815B 5F               [ 1]  189 	clrw	x
      00815C CD 82 57         [ 4]  190 	call	_eeprom_set
                                    191 ;	src/main.c: 49: uint8_t print_arr[16] = {0};
      00815F 0F 09            [ 1]  192 	clr	(0x09, sp)
      008161 0F 0A            [ 1]  193 	clr	(0x0a, sp)
      008163 0F 0B            [ 1]  194 	clr	(0x0b, sp)
      008165 0F 0C            [ 1]  195 	clr	(0x0c, sp)
      008167 0F 0D            [ 1]  196 	clr	(0x0d, sp)
      008169 0F 0E            [ 1]  197 	clr	(0x0e, sp)
      00816B 0F 0F            [ 1]  198 	clr	(0x0f, sp)
      00816D 0F 10            [ 1]  199 	clr	(0x10, sp)
      00816F 0F 11            [ 1]  200 	clr	(0x11, sp)
      008171 0F 12            [ 1]  201 	clr	(0x12, sp)
      008173 0F 13            [ 1]  202 	clr	(0x13, sp)
      008175 0F 14            [ 1]  203 	clr	(0x14, sp)
      008177 0F 15            [ 1]  204 	clr	(0x15, sp)
      008179 0F 16            [ 1]  205 	clr	(0x16, sp)
      00817B 0F 17            [ 1]  206 	clr	(0x17, sp)
      00817D 0F 18            [ 1]  207 	clr	(0x18, sp)
                                    208 ;	src/main.c: 50: eeprom_get(0, print_arr, 8);
      00817F 4B 08            [ 1]  209 	push	#0x08
      008181 4B 00            [ 1]  210 	push	#0x00
      008183 96               [ 1]  211 	ldw	x, sp
      008184 1C 00 0B         [ 2]  212 	addw	x, #11
      008187 89               [ 2]  213 	pushw	x
      008188 5F               [ 1]  214 	clrw	x
      008189 CD 82 A7         [ 4]  215 	call	_eeprom_get
                                    216 ;	src/main.c: 51: for(int j = 0; j< sizeof(print_arr); ++j)
      00818C 5F               [ 1]  217 	clrw	x
      00818D 1F 1B            [ 2]  218 	ldw	(0x1b, sp), x
      00818F                        219 00117$:
      00818F 1E 1B            [ 2]  220 	ldw	x, (0x1b, sp)
      008191 A3 00 10         [ 2]  221 	cpw	x, #0x0010
      008194 2E 1B            [ 1]  222 	jrsge	00108$
                                    223 ;	src/main.c: 53: printf("%02X", print_arr[j]);
      008196 96               [ 1]  224 	ldw	x, sp
      008197 1C 00 09         [ 2]  225 	addw	x, #9
      00819A 72 FB 1B         [ 2]  226 	addw	x, (0x1b, sp)
      00819D F6               [ 1]  227 	ld	a, (x)
      00819E 5F               [ 1]  228 	clrw	x
      00819F 97               [ 1]  229 	ld	xl, a
      0081A0 89               [ 2]  230 	pushw	x
      0081A1 4B 24            [ 1]  231 	push	#<(___str_0+0)
      0081A3 4B 80            [ 1]  232 	push	#((___str_0+0) >> 8)
      0081A5 CD 85 62         [ 4]  233 	call	_printf
      0081A8 5B 04            [ 2]  234 	addw	sp, #4
                                    235 ;	src/main.c: 51: for(int j = 0; j< sizeof(print_arr); ++j)
      0081AA 1E 1B            [ 2]  236 	ldw	x, (0x1b, sp)
      0081AC 5C               [ 1]  237 	incw	x
      0081AD 1F 1B            [ 2]  238 	ldw	(0x1b, sp), x
      0081AF 20 DE            [ 2]  239 	jra	00117$
      0081B1                        240 00108$:
                                    241 ;	src/main.c: 55: printf("\r\n");
      0081B1 AE 80 29         [ 2]  242 	ldw	x, #(___str_2+0)
      0081B4 CD 85 2E         [ 4]  243 	call	_puts
                                    244 ;	src/main.c: 56: while (1)
      0081B7                        245 00111$:
                                    246 ;	src/main.c: 58: printf("UID: ");
      0081B7 4B 2B            [ 1]  247 	push	#<(___str_3+0)
      0081B9 4B 80            [ 1]  248 	push	#((___str_3+0) >> 8)
      0081BB CD 85 62         [ 4]  249 	call	_printf
      0081BE 5B 02            [ 2]  250 	addw	sp, #2
                                    251 ;	src/main.c: 59: for(int i = 0; i< 12; ++i)
      0081C0 5F               [ 1]  252 	clrw	x
      0081C1                        253 00120$:
      0081C1 A3 00 0C         [ 2]  254 	cpw	x, #0x000c
      0081C4 2E 1B            [ 1]  255 	jrsge	00109$
                                    256 ;	src/main.c: 61: printf("%02X", tmp_uid[i]);
      0081C6 90 93            [ 1]  257 	ldw	y, x
      0081C8 72 F9 19         [ 2]  258 	addw	y, (0x19, sp)
      0081CB 90 F6            [ 1]  259 	ld	a, (y)
      0081CD 0F 1B            [ 1]  260 	clr	(0x1b, sp)
      0081CF 89               [ 2]  261 	pushw	x
      0081D0 88               [ 1]  262 	push	a
      0081D1 7B 1E            [ 1]  263 	ld	a, (0x1e, sp)
      0081D3 88               [ 1]  264 	push	a
      0081D4 4B 24            [ 1]  265 	push	#<(___str_0+0)
      0081D6 4B 80            [ 1]  266 	push	#((___str_0+0) >> 8)
      0081D8 CD 85 62         [ 4]  267 	call	_printf
      0081DB 5B 04            [ 2]  268 	addw	sp, #4
      0081DD 85               [ 2]  269 	popw	x
                                    270 ;	src/main.c: 59: for(int i = 0; i< 12; ++i)
      0081DE 5C               [ 1]  271 	incw	x
      0081DF 20 E0            [ 2]  272 	jra	00120$
      0081E1                        273 00109$:
                                    274 ;	src/main.c: 63: printf("\r\n");
      0081E1 AE 80 29         [ 2]  275 	ldw	x, #(___str_2+0)
      0081E4 CD 85 2E         [ 4]  276 	call	_puts
                                    277 ;	src/main.c: 64: ws2812_refresh();
      0081E7 CD 83 64         [ 4]  278 	call	_ws2812_refresh
                                    279 ;	src/main.c: 66: faker_delay(100000);
      0081EA 4B A0            [ 1]  280 	push	#0xa0
      0081EC 4B 86            [ 1]  281 	push	#0x86
      0081EE 4B 01            [ 1]  282 	push	#0x01
      0081F0 4B 00            [ 1]  283 	push	#0x00
      0081F2 CD 80 B3         [ 4]  284 	call	_faker_delay
      0081F5 20 C0            [ 2]  285 	jra	00111$
                                    286 ;	src/main.c: 68: }
      0081F7 5B 1C            [ 2]  287 	addw	sp, #28
      0081F9 81               [ 4]  288 	ret
                                    289 	.area CODE
                                    290 	.area CONST
                                    291 	.area CONST
      008024                        292 ___str_0:
      008024 25 30 32 58            293 	.ascii "%02X"
      008028 00                     294 	.db 0x00
                                    295 	.area CODE
                                    296 	.area CONST
      008029                        297 ___str_2:
      008029 0D                     298 	.db 0x0d
      00802A 00                     299 	.db 0x00
                                    300 	.area CODE
                                    301 	.area CONST
      00802B                        302 ___str_3:
      00802B 55 49 44 3A 20         303 	.ascii "UID: "
      008030 00                     304 	.db 0x00
                                    305 	.area CODE
                                    306 	.area INITIALIZER
                                    307 	.area CABS (ABS)
