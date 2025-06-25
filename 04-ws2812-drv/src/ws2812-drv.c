#include "gpio-reg.h"
#include "stdint.h"

#define WS2812_SERIAL_NUM       (16U)
#define WS2812_CONTRL_BIT       (24U)
static uint32_t gs_ws2812_config[WS2812_SERIAL_NUM] = {0};


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

#define ws2812_reset {                                              \
  __asm__("bres	20495, #4");                                       \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );                                                               \
  __asm__(                                                         \
    "nop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\nnop\n"           \
  );\
}

void ws2812_init(void)
{
    GPIO_D_BASE_ADDR->DDR |= (1 << 4);
    GPIO_D_BASE_ADDR->CR1 |= (1 << 4);
}

void ws2812_refresh(void)
{
  for(uint16_t i = 0; i< WS2812_CONTRL_BIT * WS2812_SERIAL_NUM; ++i)
  {
    if((gs_ws2812_config[i/WS2812_CONTRL_BIT] >> (i%WS2812_CONTRL_BIT)) & 0x1)
    {
      ws2812_send_1;
    }
    else
    {
      ws2812_send_0;
    }
  }
  ws2812_reset;
}