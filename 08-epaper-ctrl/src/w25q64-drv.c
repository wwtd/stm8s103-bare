#include "stdint.h"

extern void spi_init(void);
extern void spi_write(uint8_t data);
extern uint8_t spi_read(void);
extern void chip_select(void);
extern void chip_deselect(void);

uint16_t w25q64_read_id()
{
    uint16_t tmp = 0;
    chip_select();
    spi_write(0x90);
    spi_write(0x00);
    spi_write(0x00);
    spi_write(0x00);
    spi_read();

    tmp |= spi_read();
    tmp |= spi_read()<<8;

    chip_deselect();

    return tmp;
}

void w25q64_write_enable(void)
{
    chip_select();
    spi_write(0x06);
    chip_deselect();
}

void w25q64_wait_busy(void)
{
    unsigned char byte = 0;
    do
    {
        chip_select();
        spi_write(0x05);
        byte = spi_read();
        chip_deselect();
    }while((byte & 0x01) == 1);
}

void w25q64_erase_sector(uint32_t addr)
{
    addr *= 4096;
    w25q64_write_enable();
    w25q64_wait_busy();
    chip_select();
    spi_write(0x20);
    spi_write((uint8_t)(addr>>16));
    spi_write((uint8_t)(addr>>8));
    spi_write((uint8_t)addr);
    chip_deselect();
    w25q64_wait_busy();
}

void w25q64_write(uint8_t * buffer, uint32_t addr, uint16_t numbyte)
{
    w25q64_erase_sector(addr/4096);
    w25q64_write_enable();
    w25q64_wait_busy();
    chip_select();
    spi_write(0x02);
    spi_write((uint8_t)(addr>>16));
    spi_write((uint8_t)(addr>>8));
    spi_write((uint8_t)addr);
    for(int i = 0; i< numbyte;++i)
    {
        spi_write(buffer[i]);
    }
    chip_deselect();
    w25q64_wait_busy();
}

void w25q64_erase_chip(void)
{
    chip_select();
    w25q64_write_enable();
    spi_write(0xC7);
    chip_deselect();
}

void w25q64_read(uint8_t * buffer, uint32_t read_addr, uint16_t read_len)
{
    w25q64_wait_busy();
    chip_select();
    spi_write(0x03);
    spi_write((uint8_t)(read_addr>>16));
    spi_write((uint8_t)(read_addr>>8));
    spi_write((uint8_t)read_addr);
    spi_read();
    for(uint16_t i = 0; i< read_len; ++i)
    {
        buffer[i] = spi_read();
    }
    chip_deselect();
}