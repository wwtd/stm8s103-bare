#ifndef _GPIO_REG_H_
#define _GPIO_REG_H_

#include <stdint.h>

typedef struct {
    uint8_t ODR;
    uint8_t IDR;
    uint8_t DDR;
    uint8_t CR1;
    uint8_t CR2;
} SGpio_reg;

#define GPIO_A_BASE_ADDR    ((volatile SGpio_reg*) 0x5000)
#define GPIO_B_BASE_ADDR    ((volatile SGpio_reg*) 0x5005)
#define GPIO_C_BASE_ADDR    ((volatile SGpio_reg*) 0x500A)
#define GPIO_D_BASE_ADDR    ((volatile SGpio_reg*) 0x500F)
#define GPIO_E_BASE_ADDR    ((volatile SGpio_reg*) 0x5014)
#define GPIO_F_BASE_ADDR    ((volatile SGpio_reg*) 0x5019)

#endif // _GPIO_REG_H_