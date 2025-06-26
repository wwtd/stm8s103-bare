#include "clk-reg.h"
#include "stdint.h"

void enable_HSI_16MHz(void)
{
    // 1. 使能HSI（其实默认已启用，除非手动关闭过）
    CLK_BASE_ADDR->ICKR |= (1 << 0); // HSIEN = 1

    // 2. 等待 HSI 就绪
    while ((CLK_BASE_ADDR->ICKR & (1 << 1)) == 0); // HSIRDY = 1

    // 3. 选择 HSI 为系统时钟源
    CLK_BASE_ADDR->SWR = 0x01; // SW[2:0] = 001 => HSI

    // 4. 等待系统时钟切换完成
    while ((CLK_BASE_ADDR->CMSR & 0x07) != 0x01);

    // 5. 设置分频系数，确保 CPU 运行在 16MHz
    CLK_BASE_ADDR->CKDIVR = 0x00; // HSIDIV = 1, CPUDIV = 1

    // 到此系统时钟 = 16MHz
}