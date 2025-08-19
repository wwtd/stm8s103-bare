#include "stdio.h"
#include "stdint.h"
#include <stdint.h>
#include "i2c-reg.h"


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
extern uint16_t w25q64_read_id();
extern void w25q64_read(uint8_t * buffer, uint32_t read_addr, uint16_t read_len);
extern void w25q64_erase_chip(void);
extern void w25q64_write(uint8_t * buffer, uint32_t addr, uint16_t numbyte);
extern void i2c_init();
extern void i2c_test();
extern void ssd1306_init();
extern void epaper_display_init();
extern void ssd1680_display_frame(const uint8_t *image_bw);

void main()
{
    enable_HSI_16MHz();
    uart1_init();
    spi_init();
    epaper_display_init();
    ssd1680_display_frame(NULL);

    while (1)
    {
        faker_delay(1000000);
        printf("hello\r\n");
    }
}
