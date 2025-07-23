#ifndef _I2C_REG_H_
#define _I2C_REG_H_

#include "stdint.h"

typedef struct {
    uint8_t cr1;
    uint8_t cr2;
    uint8_t freqr;
    uint8_t oarl;
    uint8_t oarh;
    uint8_t reseved;
    uint8_t dr;
    uint8_t sr1;
    uint8_t sr2;
    uint8_t sr3;
    uint8_t itr;
    uint8_t ccrl;
    uint8_t ccrh;
    uint8_t triser;
    uint8_t pecr;
}SI2C_reg;

#define I2C_BASE_ADDR   ((volatile SI2C_reg *) 0x5210)

#endif // _I2C_REG_H_