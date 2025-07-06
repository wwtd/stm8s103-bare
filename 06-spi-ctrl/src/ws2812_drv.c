#include "gpio-reg.h"
#include "stdint.h"
#include "string.h"

#define WS2812_SERIAL_NUM       (16U)
#define WS2812_CONTRL_BIT       (24U)
#define ws2812_COLOR_GREEN		(0xFFU)
#define ws2812_COLOR_RED		(0xFF00U)
#define ws2812_COLOR_BLUE		(0xFF0000U)
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

void ws2812_blink(void)
{
	for(uint16_t i = 0; i < WS2812_SERIAL_NUM; ++i)
	{
		gs_ws2812_config[i] +=10;
		gs_ws2812_config[i] %=0x1000000;
	}
	return;
}

void ws2812_set_all_color(uint32_t color)
{
  if(color > 0xFFFFFF)
  {
    return;
  }
  for(int i =0; i< WS2812_SERIAL_NUM; ++i)
  {
	gs_ws2812_config[i] = color;
  }
}

void ws2812_set_one_color(uint16_t index, uint32_t color)
{
  if((color > 0xFFFFFF) || (index > WS2812_SERIAL_NUM))
  {
    return;
  }
  gs_ws2812_config[index] = color;
}