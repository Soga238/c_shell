/*********************************************************************
*                      Hangzhou Lingzhi Lzlinks                      *
*                        Internet of Things                          *
**********************************************************************
*                                                                    *
*            (c) 2018 - 8102 Hangzhou Lingzhi Lzlinks                *
*                                                                    *
*       www.lzlinks.com     Support: embedzjh@gmail.com              *
*                                                                    *
**********************************************************************
*                                                                    *
*       bsp.c *                                                      *
*                                                                    *
**********************************************************************
*/

#include "uart/xhal_uart.h"
#include "Driver_USART.h"
#include "bsp_cfg.h"
/*********************************************************************
*
*       Global data
*
**********************************************************************
*/

extern ARM_DRIVER_USART Driver_USART1;

const uart_mapping_t c_tUartMap[TOTAL_UART_NUM] = {
    {
        PORT_UART_GSM,
        (void *) &Driver_USART1,
        {
            0, //UART_OVERSAMPLING_16,
            0,
            NULL
        }
    }
};

/*************************** End of file ****************************/
