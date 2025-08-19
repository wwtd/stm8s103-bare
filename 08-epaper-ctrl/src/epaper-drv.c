#include "stdint.h"
#include "gpio-reg.h"
#include "spi-reg.h"
#include <stdint.h>

extern void spi_init(void);
extern void spi_write(uint8_t data);
extern void chip_select(void);
extern void chip_deselect(void);
extern void faker_delay(uint32_t cnt);

void epaper_hw_init()
{
    // D2 Reset
    GPIO_D_BASE_ADDR->DDR |= (1 << 2);
    GPIO_D_BASE_ADDR->CR1 |= (1 << 2);
    // D3 DC
    GPIO_D_BASE_ADDR->DDR |= (1 << 3);
    GPIO_D_BASE_ADDR->CR1 |= (1 << 3);
    // C3 BUSY
    GPIO_C_BASE_ADDR->DDR &= ~(1<<3);
    GPIO_C_BASE_ADDR->CR1 |= (1<<3);
}

uint8_t epaper_is_busy(void)
{
    return (GPIO_C_BASE_ADDR->IDR >> 3) & 0x01;
}

void epaper_set_reset(void)
{
    GPIO_D_BASE_ADDR->ODR |= (1<<2);
}

void epaper_reset_reset(void)
{
    GPIO_D_BASE_ADDR->ODR &= ~(1<<2);
}

void epaper_set_dc(void)
{
    GPIO_D_BASE_ADDR->ODR |= (1<<3);
}

void epaper_reset_dc(void)
{
    GPIO_D_BASE_ADDR->ODR &= ~(1<<3);
}

void epaper_write_cmd(uint8_t cmd)
{
    epaper_reset_dc();
    chip_select();
    spi_write(cmd);
    chip_deselect();
}

void epaper_write_data(uint8_t data)
{
    epaper_set_dc();
    chip_select();
    spi_write(data);
    chip_deselect();
}

void epaper_reset()
{
    epaper_reset_reset();
    faker_delay(100000);
    epaper_set_reset();
    faker_delay(100000);
}

void epaper_wait_busy()
{
    while(epaper_is_busy() != 0)
    {
        faker_delay(10000);
    }
}

void epaper_display_init()
{
    epaper_hw_init();
    epaper_reset();
    epaper_wait_busy();

    epaper_write_cmd(0x12); // SWRESET
    epaper_wait_busy();

    epaper_write_cmd(0x01); // Driver output control
    epaper_write_data(0xF9); // MUX = 250
    epaper_write_data(0x00);
    epaper_write_data(0x00);

    epaper_write_cmd(0x11); // data entry mode
    epaper_write_data(0x01);

    epaper_write_cmd(0x44); // set RAM x address
    epaper_write_data(0x00);
    epaper_write_data(0x0F); // 0x0F = (width/8)-1

    epaper_write_cmd(0x45); // set RAM y address
    epaper_write_data(0xF9); // y start
    epaper_write_data(0x00);
    epaper_write_data(0x00); // y end
    epaper_write_data(0x00);
}

void ssd1680_display_frame(const uint8_t *image_bw) {
    uint16_t width = 128;
    uint16_t height = 250;

    epaper_write_cmd(0x24);
    uint8_t tmp = 0;
    for (uint32_t i = 0; i < (width / 8) * height; i++) {

        epaper_write_data(0xAA);

    }

    epaper_write_cmd(0x22);
    epaper_write_data(0xF7);
    epaper_write_cmd(0x20);
    epaper_wait_busy();
}