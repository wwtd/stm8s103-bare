#include "gpio-reg.h"
#include "i2c-reg.h"
#include "stdint.h"

#define I2C_SR1     (*(volatile uint8_t*)0x5217)
#define I2C_SR2     (*(volatile uint8_t*)0x5218)
#define I2C_SR3     (*(volatile uint8_t*)0x5219)

void i2c_init()
{
    // GPIO config
    GPIO_B_BASE_ADDR->DDR &= ~((1 << 4) | (1 << 5));
    GPIO_B_BASE_ADDR->CR1 |= (1 << 4) | (1 << 5);
    GPIO_B_BASE_ADDR->CR2 |= (1 << 4) | (1 << 5);

    I2C_BASE_ADDR->cr1 &= ~(1 << 0);  // PE = 0
    // f_master = 16 MHz → freqr = 16
    I2C_BASE_ADDR->freqr = 16;
    // CCR = f_master / (2 * f_SCL) = 16MHz / (2 * 100kHz) = 80 (0x50)
    I2C_BASE_ADDR->ccrl = 0x50;
    I2C_BASE_ADDR->ccrh = 0x00;
    // trise = (1000ns / T_master) + 1 = (1000ns / 62.5ns) + 1 ≈ 17 (0x11)
    I2C_BASE_ADDR->triser = 0x11;
    I2C_BASE_ADDR->cr1 |= (1 << 0);  // PE = 1
}

void i2c_start()
{
    I2C_BASE_ADDR->cr2 |= (1<<0);
    while(!(I2C_BASE_ADDR->sr1 & (1<<0)));
    (void)I2C_SR1;
}

void i2c_stop()
{
    while((I2C_BASE_ADDR->sr1 & 0x4) == 0);
    I2C_BASE_ADDR->cr2 |= (1<<1);
}

uint8_t i2c_send_addr(uint8_t addr)
{
    I2C_BASE_ADDR->dr = 0x78;
    
    while(!(I2C_BASE_ADDR->sr1 & 0x02));

    (void)I2C_SR1;
    (void)I2C_SR3;

    return 0;
}

uint8_t i2c_send_byte(uint8_t byte)
{
    I2C_BASE_ADDR->dr = byte;

    while(!(I2C_BASE_ADDR->sr1 & 0x80));
    return 0;
}

void i2c_test()
{
    i2c_start();
    i2c_send_addr(0x78);
    i2c_send_byte(0x00);
    i2c_send_byte(0xAE);
    i2c_stop();
}