#include "gpio-reg.h"
#include "stdint.h"

void on_board_led_init()
{
    GPIO_B_BASE_ADDR->DDR |= (1 << 5);
    GPIO_B_BASE_ADDR->CR1 |= (1 << 5);
}

void on_board_led_blink()
{
    GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
}