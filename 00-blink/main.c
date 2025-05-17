#include <stdint.h>

#define PB_ODR  (*(volatile uint8_t*)0x5005)
#define PB_DDR  (*(volatile uint8_t*)0x5007)
#define PB_CR1  (*(volatile uint8_t*)0x5008)

void delay() {
    for (volatile uint32_t i = 0; i < 50000; ++i);
}

void main() {
    PB_DDR |= (1 << 5);  // PB5 设置为输出
    PB_CR1 |= (1 << 5);  // 推挽输出模式

    while (1) {
        PB_ODR ^= (1 << 5);  // 翻转 PB5
        delay();
    }
}
