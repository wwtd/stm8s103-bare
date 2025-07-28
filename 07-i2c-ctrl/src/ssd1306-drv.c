#include "stdint.h"
#include <stdint.h>
#include "stdio.h"

extern void i2c_start();
extern void i2c_stop();
extern uint8_t i2c_send_addr(uint8_t addr);
extern uint8_t i2c_send_byte(uint8_t byte);


void ssd1306_write_cmd(uint8_t cmd)
{
    i2c_start();
    i2c_send_addr(0x78);
    i2c_send_byte(0x00);
    i2c_send_byte(cmd);
    i2c_stop();
}

void ssd1306_write_data(uint8_t data) {
    i2c_start();
    i2c_send_addr(0x78);
    i2c_send_byte(0x40);
    i2c_send_byte(data);
    i2c_stop();
}

void ssd1306_write_buffer(uint8_t * buffer, uint16_t len)
{
    i2c_start();
    i2c_send_byte(0x78);
    i2c_send_byte(0x40);
    for(int i =0; i < len-1; ++i)
    {
        i2c_send_byte(buffer[i]);
    }
    i2c_send_byte(buffer[len -1]);
    i2c_stop();
}

void ssd1306_turn_all_on()
{
    ssd1306_write_cmd(0xA5);
}

void ssd1306_init()
{
    static const uint8_t init_seq[] = {
        0xAE,         // Display OFF
        0xD5, 0x80,   // Set Display Clock
        0xA8, 0x3F,   // Set MUX ratio (1 to 64)
        0xD3, 0x00,   // Set display offset
        0x40,         // Set display start line
        0x8D, 0x14,   // Enable charge pump
        0x20, 0x00,   // Set Memory Addressing Mode: Page Mode
        0xA1,         // Set Segment Re-map (mirror horizontally)
        0xC8,         // Set COM Output Scan Direction: remapped mode
        0xDA, 0x12,   // Set COM Pins hardware configuration
        0x81, 0x7F,   // Set contrast control
        0xD9, 0xF1,   // Set pre-charge period
        0xDB, 0x40,   // Set VCOMH deselect level
        0xA4,         // Resume to RAM content display
        0xA6,         // Normal display (not inverted)
        0xAF,          // Display ON
    };
    for (uint8_t i = 0; i < sizeof(init_seq); i++) {
        ssd1306_write_cmd(init_seq[i]);
    }
}