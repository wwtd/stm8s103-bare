#include <stdint.h>
#include "gpio-reg.h"

void delay(uint16_t cnt) {
    for (volatile uint16_t i = 0; i < cnt; ++i);
}

void main() {
    GPIO_B_BASE_ADDR->DDR |= (1 << 5);
    GPIO_B_BASE_ADDR->CR1 |= (1 << 5);

    GPIO_A_BASE_ADDR->DDR |= (1 << 1);
    GPIO_A_BASE_ADDR->CR1 |= (1 << 1);

    while (1) {
        GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
        GPIO_A_BASE_ADDR->ODR ^= (1 << 1);
        delay(10000);
    }
}
