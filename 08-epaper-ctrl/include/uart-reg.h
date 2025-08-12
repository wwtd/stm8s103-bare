#ifndef _UART_REG_H_
#define _UART_REG_H_

#include <stdint.h>

typedef struct {
    uint8_t SR;
    uint8_t DR;
    uint8_t BRR1;
    uint8_t BRR2;
    uint8_t CR1;
    uint8_t CR2;
    uint8_t CR3;
    uint8_t CR4;
    uint8_t CR5;
    uint8_t GTR;
    uint8_t PSCR;
}SUart_reg;

#define UART_1_BASE_ADDR    ((volatile SUart_reg *)0x5230)

#endif // _UART_REG_H_