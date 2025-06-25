#include "stdio.h"
#include "stdint.h"


extern void faker_delay(uint16_t cnt);
extern void uart1_init(void);
extern void enable_HSI_16MHz(void);
extern void on_board_led_init(void);
extern void on_board_led_blink(void);
extern void ws2812_init(void);
extern void ws2812_refresh(void);


void main()
{
    enable_HSI_16MHz();
    on_board_led_init();
    uart1_init();
    ws2812_init();
    while (1)
    {
        // printf("hello\r\n");
        ws2812_refresh();
        faker_delay(10000);
    }
}
