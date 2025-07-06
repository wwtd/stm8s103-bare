#include "flash-reg.h"
#include "stdint.h"
#include "stdio.h"
#include "string.h"
#include <stdint.h>


#define EEPROM_START_ADDR       ((uint8_t *)0x4000)
#define EEPROM_LEN              (640U)
#define EEPROM_FIRST_HW_KEY     (0xAE)
#define EEPROM_SECOND_HW_KEY    (0x56)
#define FLASH_IAPSR_DUL_MASK    (8)
#define FLASH_IAPSR_EOP_MASK    (4)

void eeprom_dump(void)
{
    for(int i = 0 ;i < EEPROM_LEN; ++i)
    {
        if(i % 8  == 7)
        {
            printf("%02X\r\n", *((EEPROM_START_ADDR + i)));
        }
        else
        {
            printf("%02X", (uint8_t)(*(EEPROM_START_ADDR + i)));
        }
    }
    printf("\r\n");
}

void eeprom_set(uint16_t index, uint8_t * data, uint16_t len)
{
    if(index + len > EEPROM_LEN)
    {
        return;
    }

    // unlock eeprom
    FLASH_BASE_ADDR->dukr = EEPROM_FIRST_HW_KEY;
    FLASH_BASE_ADDR->dukr = EEPROM_SECOND_HW_KEY;
    while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_DUL_MASK));

    // write data
    for(int i = 0; i<len; ++i)
    {
        (*(volatile uint8_t *)(EEPROM_START_ADDR + index + i)) = data[i];
        while(!(FLASH_BASE_ADDR->iapsr & FLASH_IAPSR_EOP_MASK));
    }
    // lock eeprom
    FLASH_BASE_ADDR->iapsr &= ~(FLASH_IAPSR_DUL_MASK);
}

void eeprom_get(uint16_t index, uint8_t * buffer, uint16_t len)
{
    memcpy(buffer, (volatile uint8_t *)(EEPROM_START_ADDR + index), len);
}