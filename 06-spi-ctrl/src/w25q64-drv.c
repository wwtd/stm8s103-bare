#include "stdint.h"

extern void spi_init(void);
extern void spi_write(uint8_t data);
extern uint8_t spi_read(void);
extern void chip_select(void);
extern void chip_deselect(void);

uint16_t ws25q64_read_id()
{
    uint16_t tmp = 0;
    chip_select();
    spi_write(0x90);
    spi_write(0x00);
    spi_write(0x00);
    spi_write(0x00);

    tmp |= spi_read();
    tmp |= spi_read()<<8;

    chip_deselect();

    return tmp;
}

