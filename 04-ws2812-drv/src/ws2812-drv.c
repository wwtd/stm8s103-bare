#include "gpio-reg.h"
#include "stdint.h"

#define WS2812_SERIAL_NUM       (16U)
static uint32_t gs_ws2812_config[WS2812_SERIAL_NUM] = {0};

void ws2812_inint(void)
{
    GPIO_D_BASE_ADDR->DDR |= (1 << 4);
    GPIO_D_BASE_ADDR->CR1 |= (1 << 4);
}

#define ws2812_send_1 {                                                   \
  __asm__("bset	20495, #4");                                       \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n" \
  );                                                               \
  __asm__("bres	20495, #4");                                       \
  __asm__(                                                         \
    "nop\nnop\nnop\n"                                              \
  );                                                               \
}

#define ws2812_send_0 {                                                   \
  __asm__("bset	20495, #4");                                       \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\n"                                    \
  );                                                               \
  __asm__("bres	20495, #4");                                       \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
}

void send_raw_color(uint32_t color) {
  for(int i=0; i<24; i++) {
    if(color & 1) {
      ws2812_send_1;
    } else {
      ws2812_send_0;
    }
    color >>= 1;
  }
}
