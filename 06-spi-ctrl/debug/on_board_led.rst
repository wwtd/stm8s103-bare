                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module on_board_led
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _on_board_led_blink
                                     12 	.globl _on_board_led_init
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; absolute external ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DABS (ABS)
                                     25 
                                     26 ; default segment ordering for linker
                                     27 	.area HOME
                                     28 	.area GSINIT
                                     29 	.area GSFINAL
                                     30 	.area CONST
                                     31 	.area INITIALIZER
                                     32 	.area CODE
                                     33 
                                     34 ;--------------------------------------------------------
                                     35 ; global & static initialisations
                                     36 ;--------------------------------------------------------
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area GSINIT
                                     41 ;--------------------------------------------------------
                                     42 ; Home
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area HOME
                                     46 ;--------------------------------------------------------
                                     47 ; code
                                     48 ;--------------------------------------------------------
                                     49 	.area CODE
                                     50 ;	src/on_board_led.c: 4: void on_board_led_init()
                                     51 ;	-----------------------------------------
                                     52 ;	 function on_board_led_init
                                     53 ;	-----------------------------------------
      0081FA                         54 _on_board_led_init:
                                     55 ;	src/on_board_led.c: 6: GPIO_B_BASE_ADDR->DDR |= (1 << 5);
      0081FA 72 1A 50 07      [ 1]   56 	bset	0x5007, #5
                                     57 ;	src/on_board_led.c: 7: GPIO_B_BASE_ADDR->CR1 |= (1 << 5);
      0081FE 72 1A 50 08      [ 1]   58 	bset	0x5008, #5
                                     59 ;	src/on_board_led.c: 8: }
      008202 81               [ 4]   60 	ret
                                     61 ;	src/on_board_led.c: 10: void on_board_led_blink()
                                     62 ;	-----------------------------------------
                                     63 ;	 function on_board_led_blink
                                     64 ;	-----------------------------------------
      008203                         65 _on_board_led_blink:
                                     66 ;	src/on_board_led.c: 12: GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
      008203 90 1A 50 05      [ 1]   67 	bcpl	0x5005, #5
                                     68 ;	src/on_board_led.c: 13: }
      008207 81               [ 4]   69 	ret
                                     70 	.area CODE
                                     71 	.area CONST
                                     72 	.area INITIALIZER
                                     73 	.area CABS (ABS)
