#ifndef _ADC_REG_H_
#define _ADC_REG_H_

#include <stdint.h>

typedef struct{
    uint8_t DBxR[20];
    uint8_t reserved[12];
    uint8_t CSR;
    uint8_t CR1;
    uint8_t CR2;
    uint8_t CR3;
    uint8_t DRH;
    uint8_t DRL;
    uint8_t TDRH;
    uint8_t TDRL;
    uint8_t HTRH;
    uint8_t HTRL;
    uint8_t LTRH;
    uint8_t LTRL;
    uint8_t AWSRH;
    uint8_t AWSRKL;
    uint8_t AWSCRH;
    uint8_t AWSCRL;
} SADC_reg;

#define ADC_BASE_ADDR    ((volatile SADC_reg*) 0x53E0)

#endif //_ADC_REG_H_