#include "flash-reg.h"
#include "stdint.h"
#include "string.h"

#define FLASH_START_ADDR       ((uint8_t *)0x807F)
#define FLASH_LEN              (8064U)
#define FLASH_FIRST_HW_KEY     (0xAE)
#define FLASH_SECOND_HW_KEY    (0x56)
#define FLASH_IAPSR_PUL_MASK   (2U)
#define FLASH_IAPSR_EOP_MASK   (4U)


void flash_set(uint16_t index, uint8_t * data, uint16_t len)
{
    if(index + len > FLASH_LEN)
    {
        return;
    }

    // unlock flash
    FLASH_BASE_ADDR->dukr = FLASH_FIRST_HW_KEY;
    FLASH_BASE_ADDR->dukr = FLASH_SECOND_HW_KEY;
    while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_PUL_MASK));

    // write data
    for(int i = 0; i<len; ++i)
    {
        (*(volatile uint8_t *)(FLASH_START_ADDR + index + i)) = data[i];
        while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
    }
    // lock flash
    FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_PUL_MASK);
}

void flash_get(uint16_t index, uint8_t * buffer, uint16_t len)
{
    memcpy(buffer, (volatile uint8_t *)(FLASH_START_ADDR + index), len);
}
