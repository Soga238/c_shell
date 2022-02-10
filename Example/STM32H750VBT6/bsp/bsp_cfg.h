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
*       bsp_cfg.h *                                                  *
*                                                                    *
**********************************************************************
*/
#ifndef __BSP_CFG_H__
#define __BSP_CFG_H__

#ifdef __cplusplus
extern "C" {
#endif


#define XHAL_OK                     0
#define XHAL_FAIL                  -1

#define WAIT_FOREVER                osWaitForever

/*! user peripherals */

/*! GPIO */
#define TOTAL_GPIO_NUM              6

#define PORT_LED0                   0
#define PORT_LED1                   1
#define PORT_LED2                   2
#define PORT_GSM_RUN                2
#define PORT_GSM_PWR                3
#define PORT_GSM_STATUS             5


/*! UART */
#define TOTAL_UART_NUM              2

#define PORT_UART_GSM               0

#ifdef __cplusplus
}
#endif

#endif
/*************************** End of file ****************************/
