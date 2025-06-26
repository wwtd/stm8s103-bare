#include "uart-reg.h"
#include "clk-reg.h"
#include "stdint.h"


void uart1_init()
{
    CLK_BASE_ADDR->PCKENR1 |= (1 << 3);
    UART_1_BASE_ADDR->BRR2 = 0x0A;
    UART_1_BASE_ADDR->BRR1 = 0x08;
    UART_1_BASE_ADDR->CR2 = ((1<<2)|(1<<3));
}

void uart1_send_char(const char ch)
{
    UART_1_BASE_ADDR->DR = ch;
    while(!(UART_1_BASE_ADDR->SR & (1<<6)));
}

int putchar(int ch)
{
    uart1_send_char(ch);
    return 0;
}