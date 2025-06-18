#include "gpio-reg.h"
#include "uart-reg.h"
#include "clk-reg.h"
#include "adc-reg.h"
#include "stddef.h"
#include "stdio.h"

void adc_init(uint8_t channel)
{
    // 1. 使能 ADC 时钟（STM8S103 自动打开，无需单独 RCC 配置）

    // 2. 选择通道
    ADC_BASE_ADDR->CSR = channel & 0x0F;  // CSR[3:0] 是通道选择，0~7

    // 3. 设置 CR1：开启 ADC，选择时钟分频（可选）
    ADC_BASE_ADDR->CR1 = 0x01; // ADON = 1，启动 ADC 模块

    // 4. 设置 CR2：配置单次或连续转换等
    ADC_BASE_ADDR->CR2 = 0x00; // 单次转换模式，右对齐

    // 5. 设置 CR3：可以不配置，默认即可
}

uint16_t adc_read()
{
    // 1. 启动转换
    ADC_BASE_ADDR->CR1 |= 0x01; // 再次写入 ADON=1，开始转换

    // 2. 等待 EOC (End Of Conversion) 标志位设置
    while ((ADC_BASE_ADDR->CSR & 0x80) == 0); // CSR[7] 是 EOC

    // 3. 读取 DRH 和 DRL
    uint8_t high = ADC_BASE_ADDR->DRH;
    uint8_t low  = ADC_BASE_ADDR->DRL;

    return ((uint16_t)high << 2) | (low & 0x03); // 10 位数据：高8位<<2 + 低2位
}

void delay(uint16_t cnt)
{
    for (volatile uint16_t i = 0; i < cnt; ++i);
}

void uart1_init()
{
    CLK_BASE_ADDR->PCKENR1 |= (1 << 3);
    UART_1_BASE_ADDR->BRR2 = 0x00;
    UART_1_BASE_ADDR->BRR1 = 0x0D;
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

void on_board_led_init()
{
    GPIO_B_BASE_ADDR->DDR |= (1 << 5);
    GPIO_B_BASE_ADDR->CR1 |= (1 << 5);
    GPIO_A_BASE_ADDR->DDR |= (1 << 1);
    GPIO_A_BASE_ADDR->CR1 |= (1 << 1);
}

void on_board_led_blink()
{
    GPIO_B_BASE_ADDR->ODR ^= (1 << 5);
    GPIO_A_BASE_ADDR->ODR ^= (1 << 1);
}

void main()
{
    on_board_led_init();
    uart1_init();
    adc_init(3);
    while (1) {
        on_board_led_blink();
        uint16_t adc_val = adc_read();
        printf("adc_val: %04X\r\n", adc_val);
        delay(10000);
    }
}
