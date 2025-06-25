#include "stdint.h"

void faker_delay(uint32_t cnt)
{
    for (volatile uint32_t i = 0; i < cnt; ++i);
}