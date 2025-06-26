#include "stdio.h"
#include "stdint.h"


extern void faker_delay(uint32_t cnt);
extern void uart1_init(void);
extern void enable_HSI_16MHz(void);
extern void on_board_led_init(void);
extern void on_board_led_blink(void);
extern void ws2812_init(void);
extern void ws2812_refresh(void);
extern void ws2812_blink(void);
extern void ws2812_set_all_color(uint32_t color);
extern void ws2812_set_one_color(uint16_t index, uint32_t color);
extern uint8_t * get_uid(void);


void main()
{
    enable_HSI_16MHz();
    on_board_led_init();
    uart1_init();
    ws2812_init();
    // ws2812_set_all_color(0xFFFFFF);
    for(int i = 0; i < 16; ++i)
    {
        if(i%3 == 0)
        {
            ws2812_set_one_color(i, 0xFF);
        }
        else if(i%3 == 1)
        {
            ws2812_set_one_color(i, 0xFF00);
        }
        else
        {
            ws2812_set_one_color(i, 0xFF0000);
        }
    }

    uint8_t * tmp_uid = get_uid();

    while (1)
    {
        printf("UID: ");
        for(int i = 0; i< 12; ++i)
        {
            printf("%02X", tmp_uid[i]);
        }
        printf("\r\n");
        ws2812_refresh();
        // ws2812_blink();
        faker_delay(100000);
    }
}
