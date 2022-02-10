# 1 "../../bsp/bsp.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 374 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "./RTE/_Target_1\\Pre_Include_Global.h" 1
# 2 "<built-in>" 2
# 1 "../../bsp/bsp.c" 2
# 17 "../../bsp/bsp.c"
# 1 "../../bsp/uart/xhal_uart.h" 1
# 23 "../../bsp/uart/xhal_uart.h"
# 1 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stdint.h" 1 3
# 56 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stdint.h" 3
typedef signed char int8_t;
typedef signed short int int16_t;
typedef signed int int32_t;
typedef signed long long int int64_t;


typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long int uint64_t;





typedef signed char int_least8_t;
typedef signed short int int_least16_t;
typedef signed int int_least32_t;
typedef signed long long int int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;
typedef unsigned long long int uint_least64_t;




typedef signed int int_fast8_t;
typedef signed int int_fast16_t;
typedef signed int int_fast32_t;
typedef signed long long int int_fast64_t;


typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef unsigned long long int uint_fast64_t;






typedef signed int intptr_t;
typedef unsigned int uintptr_t;



typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
# 24 "../../bsp/uart/xhal_uart.h" 2







typedef struct {
    uint8_t chPort;
    void *ptUartPhy;


    struct {
        uint32_t wOverSampling;
        uint16_t hwBufSize;
        uint8_t *pchBuf;
    };

}uart_mapping_t;
# 18 "../../bsp/bsp.c" 2
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include\\Driver_USART.h" 1
# 65 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include\\Driver_USART.h"
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h" 1
# 37 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h"
# 1 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 1 3
# 38 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
  typedef signed int ptrdiff_t;
# 53 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
    typedef unsigned int size_t;
# 71 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
      typedef unsigned short wchar_t;
# 95 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
  typedef long double max_align_t;
# 38 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h" 2

# 1 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stdbool.h" 1 3
# 40 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h" 2






typedef struct _ARM_DRIVER_VERSION {
  uint16_t api;
  uint16_t drv;
} ARM_DRIVER_VERSION;
# 63 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h"
typedef enum _ARM_POWER_STATE {
  ARM_POWER_OFF,
  ARM_POWER_LOW,
  ARM_POWER_FULL
} ARM_POWER_STATE;
# 66 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include\\Driver_USART.h" 2
# 161 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include\\Driver_USART.h"
typedef struct _ARM_USART_STATUS {
  uint32_t tx_busy : 1;
  uint32_t rx_busy : 1;
  uint32_t tx_underflow : 1;
  uint32_t rx_overflow : 1;
  uint32_t rx_break : 1;
  uint32_t rx_framing_error : 1;
  uint32_t rx_parity_error : 1;
  uint32_t reserved : 25;
} ARM_USART_STATUS;




typedef enum _ARM_USART_MODEM_CONTROL {
  ARM_USART_RTS_CLEAR,
  ARM_USART_RTS_SET,
  ARM_USART_DTR_CLEAR,
  ARM_USART_DTR_SET
} ARM_USART_MODEM_CONTROL;




typedef struct _ARM_USART_MODEM_STATUS {
  uint32_t cts : 1;
  uint32_t dsr : 1;
  uint32_t dcd : 1;
  uint32_t ri : 1;
  uint32_t reserved : 28;
} ARM_USART_MODEM_STATUS;
# 289 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include\\Driver_USART.h"
typedef void (*ARM_USART_SignalEvent_t) (uint32_t event);





typedef struct _ARM_USART_CAPABILITIES {
  uint32_t asynchronous : 1;
  uint32_t synchronous_master : 1;
  uint32_t synchronous_slave : 1;
  uint32_t single_wire : 1;
  uint32_t irda : 1;
  uint32_t smart_card : 1;
  uint32_t smart_card_clock : 1;
  uint32_t flow_control_rts : 1;
  uint32_t flow_control_cts : 1;
  uint32_t event_tx_complete : 1;
  uint32_t event_rx_timeout : 1;
  uint32_t rts : 1;
  uint32_t cts : 1;
  uint32_t dtr : 1;
  uint32_t dsr : 1;
  uint32_t dcd : 1;
  uint32_t ri : 1;
  uint32_t event_cts : 1;
  uint32_t event_dsr : 1;
  uint32_t event_dcd : 1;
  uint32_t event_ri : 1;
  uint32_t reserved : 11;
} ARM_USART_CAPABILITIES;





typedef struct _ARM_DRIVER_USART {
  ARM_DRIVER_VERSION (*GetVersion) (void);
  ARM_USART_CAPABILITIES (*GetCapabilities) (void);
  int32_t (*Initialize) (ARM_USART_SignalEvent_t cb_event);
  int32_t (*Uninitialize) (void);
  int32_t (*PowerControl) (ARM_POWER_STATE state);
  int32_t (*Send) (const void *data, uint32_t num);
  int32_t (*Receive) ( void *data, uint32_t num);
  int32_t (*Transfer) (const void *data_out,
                                                   void *data_in,
                                             uint32_t num);
  uint32_t (*GetTxCount) (void);
  uint32_t (*GetRxCount) (void);
  int32_t (*Control) (uint32_t control, uint32_t arg);
  ARM_USART_STATUS (*GetStatus) (void);
  int32_t (*SetModemControl) (ARM_USART_MODEM_CONTROL control);
  ARM_USART_MODEM_STATUS (*GetModemStatus) (void);
} const ARM_DRIVER_USART;
# 19 "../../bsp/bsp.c" 2
# 1 "../../bsp/bsp_cfg.h" 1
# 20 "../../bsp/bsp.c" 2







extern ARM_DRIVER_USART Driver_USART1;

const uart_mapping_t c_tUartMap[2] = {
    {
        0,
        (void *) &Driver_USART1,
        {
            0,
            0,
            0
        }
    }
};
