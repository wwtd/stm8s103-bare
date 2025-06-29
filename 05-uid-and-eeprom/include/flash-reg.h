#ifndef _FLASH_REG_H_
#define _FLASH_REG_H_

#include "stdint.h"

typedef struct {
    uint8_t cr1;
    uint8_t cr2;
    uint8_t ncr2;
    uint8_t fpr;
    uint8_t nfpr;
    uint8_t iapsr;
    uint8_t reserved1[2];
    uint8_t pukr;
    uint8_t reserved2;
    uint8_t dukr;
}SFlash_reg;

#define FLASH_BASE_ADDR     ((volatile SFlash_reg *)0x505A)

#endif // _FLASH_REG_H_