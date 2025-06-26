#ifndef _CLK_REG_H_
#define _CLK_REG_H_

#include "stdint.h" 

typedef struct{
    uint8_t ICKR;
    uint8_t ECKR;
    uint8_t reserved;
    uint8_t CMSR;
    uint8_t SWR;
    uint8_t SWCR;
    uint8_t CKDIVR;
    uint8_t PCKENR1;
    uint8_t CSSR;
    uint8_t CCOR;
    uint8_t PCKENR2;
    uint8_t CANCCR;
    uint8_t HSITRIMR;
    uint8_t SWIMCCR;
} SClk_reg;

#define CLK_BASE_ADDR    ((volatile SClk_reg *)0x50C0)

#endif //_CLK_REG_H_