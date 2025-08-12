#ifndef _SPI_REG_H_
#define _SPI_REG_H_

#include "stdint.h"

typedef struct {
    uint8_t cr1;
    uint8_t cr2;
    uint8_t icr;
    uint8_t sr;
    uint8_t dr;
    uint8_t crcpr;
    uint8_t rxcrcr;
    uint8_t txcrcr;
}SSpi_reg;

#define SPI_BASE_ADDR   ((volatile SSpi_reg *) 0x5200)

#endif // _SPI_REG_H_