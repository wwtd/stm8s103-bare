#include "stdint.h"
#include "string.h"

#define UID_START_ADDR      ((uint8_t *) 0x4865U)
#define UID_LEN             (12U)
static uint8_t gs_uid_buffer[UID_LEN] = {0};

uint8_t * get_uid(void)
{
    memcpy(gs_uid_buffer, UID_START_ADDR, UID_LEN);
    return gs_uid_buffer;
}
