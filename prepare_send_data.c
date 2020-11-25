#include "const-tx-server.h"

int prepare_send_data(char *buf, int buflen)
{
    /* simple data. all 'X' (0x58) */
    memset(buf, 'X', buflen);
    return buflen;
}
