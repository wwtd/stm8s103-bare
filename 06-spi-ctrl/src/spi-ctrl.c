#include "gpio-reg.h"
#include "spi-reg.h"
#include "stdint.h"
#include <stdint.h>


/*
 * SPI pinout:
 * SCK  -> PC5
 * MOSI -> PC6
 * MISO -> PC7
 * CS   -> PC4
 */

void spi_init(void)
{
    GPIO_C_BASE_ADDR->DDR |= (1<<4);
    GPIO_C_BASE_ADDR->CR1 |= (1<<4);
    GPIO_C_BASE_ADDR->ODR |= (1<<4);

    // SSM SSI MSTR SPE BR0
    SPI_BASE_ADDR->cr2 = (1<<1)|(1<<0);
    SPI_BASE_ADDR->cr1 = (1<<2)|(1<<6)|(1<<3);
}

void spi_write(uint8_t data)
{
    SPI_BASE_ADDR->dr = data;
    while(!(SPI_BASE_ADDR->sr & (1<<1)));
}

uint8_t spi_read(void)
{
    spi_write(0xFF);
    while(!(SPI_BASE_ADDR->sr) & (1<<0));
    return (SPI_BASE_ADDR->dr);
}

void chip_select(void)
{
    GPIO_C_BASE_ADDR->ODR &= ~(1<<4);
}

void chip_deselect(void)
{
    GPIO_C_BASE_ADDR->ODR |= (1<<4);
}