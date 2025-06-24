#include "stdint.h"

void faker_delay(uint16_t cnt)
{
    for (volatile uint16_t i = 0; i < cnt; ++i);
}