#include "stdio.h"
#include "stdint.h"
#include <stdint.h>


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
extern void eeprom_dump(void);
extern void eeprom_set(uint16_t index, uint8_t * data, uint16_t len);
extern void eeprom_get(uint16_t index, uint8_t * buffer, uint16_t len);
extern void spi_init(void);
extern void spi_write(uint8_t data);
extern uint8_t spi_read(void);
extern void chip_select(void);
extern void chip_deselect(void);


void main()
{
    enable_HSI_16MHz();
    on_board_led_init();
    uart1_init();
    spi_init();
    uint8_t * tmp_uid = get_uid();
    printf("UID: ");
    for(int i = 0; i< 12; ++i)
    {
        printf("%02X", tmp_uid[i]);
    }
    printf("\r\n");
    while (1)
    {
        chip_select();
        for(uint8_t i = 0xAA; i< 0xFA; i++)
        {
            spi_write(i);
        }
        chip_deselect();
        faker_delay(100000);
    }
}
