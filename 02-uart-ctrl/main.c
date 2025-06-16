#include "gpio-reg.h"
#include "uart-reg.h"
#include "clk-reg.h"
#include "stddef.h"

void delay(uint16_t cnt) {
    for (volatile uint16_t i = 0; i < cnt; ++i);
}

void uart1_send_char(const char ch)
{
    UART_1_BASE_ADDR->DR = ch;
    while(!(UART_1_BASE_ADDR->SR & (1<<6)));
}

void uart1_send_string(const char * str)
{
    while(*str != NULL)
    {
        uart1_send_char(*str);
        str++;
    }
}


void main() {
    GPIO_B_BASE_ADDR->DDR |= (1 << 5);
    GPIO_B_BASE_ADDR->CR1 |= (1 << 5);

    GPIO_A_BASE_ADDR->DDR |= (1 << 1);
    GPIO_A_BASE_ADDR->CR1 |= (1 << 1);

    CLK_BASE_ADDR->PCKENR1 |= (1 << 3);
    UART_1_BASE_ADDR->BRR2 = 0x00;
    UART_1_BASE_ADDR->BRR1 = 0x0D;
    UART_1_BASE_ADDR->CR2 = ((1<<2)|(1<<3));

    while (1) {
        GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
        GPIO_A_BASE_ADDR->ODR ^= (1 << 1);
        uart1_send_string("hello\r\n");
        delay(10000);
    }
}
