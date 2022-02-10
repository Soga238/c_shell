# 1 "../../usr_app/usr_app.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 374 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "./RTE/_Target_1\\Pre_Include_Global.h" 1
# 2 "<built-in>" 2
# 1 "../../usr_app/usr_app.c" 2
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
# 39 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Driver/Include/Driver_Common.h" 2
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
# 2 "../../usr_app/usr_app.c" 2
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h" 1
# 76 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
typedef struct {
  uint32_t api;
  uint32_t kernel;
} osVersion_t;


typedef enum {
  osKernelInactive = 0,
  osKernelReady = 1,
  osKernelRunning = 2,
  osKernelLocked = 3,
  osKernelSuspended = 4,
  osKernelError = -1,
  osKernelReserved = 0x7FFFFFFF
} osKernelState_t;


typedef enum {
  osThreadInactive = 0,
  osThreadReady = 1,
  osThreadRunning = 2,
  osThreadBlocked = 3,
  osThreadTerminated = 4,
  osThreadError = -1,
  osThreadReserved = 0x7FFFFFFF
} osThreadState_t;


typedef enum {
  osPriorityNone = 0,
  osPriorityIdle = 1,
  osPriorityLow = 8,
  osPriorityLow1 = 8+1,
  osPriorityLow2 = 8+2,
  osPriorityLow3 = 8+3,
  osPriorityLow4 = 8+4,
  osPriorityLow5 = 8+5,
  osPriorityLow6 = 8+6,
  osPriorityLow7 = 8+7,
  osPriorityBelowNormal = 16,
  osPriorityBelowNormal1 = 16+1,
  osPriorityBelowNormal2 = 16+2,
  osPriorityBelowNormal3 = 16+3,
  osPriorityBelowNormal4 = 16+4,
  osPriorityBelowNormal5 = 16+5,
  osPriorityBelowNormal6 = 16+6,
  osPriorityBelowNormal7 = 16+7,
  osPriorityNormal = 24,
  osPriorityNormal1 = 24+1,
  osPriorityNormal2 = 24+2,
  osPriorityNormal3 = 24+3,
  osPriorityNormal4 = 24+4,
  osPriorityNormal5 = 24+5,
  osPriorityNormal6 = 24+6,
  osPriorityNormal7 = 24+7,
  osPriorityAboveNormal = 32,
  osPriorityAboveNormal1 = 32+1,
  osPriorityAboveNormal2 = 32+2,
  osPriorityAboveNormal3 = 32+3,
  osPriorityAboveNormal4 = 32+4,
  osPriorityAboveNormal5 = 32+5,
  osPriorityAboveNormal6 = 32+6,
  osPriorityAboveNormal7 = 32+7,
  osPriorityHigh = 40,
  osPriorityHigh1 = 40+1,
  osPriorityHigh2 = 40+2,
  osPriorityHigh3 = 40+3,
  osPriorityHigh4 = 40+4,
  osPriorityHigh5 = 40+5,
  osPriorityHigh6 = 40+6,
  osPriorityHigh7 = 40+7,
  osPriorityRealtime = 48,
  osPriorityRealtime1 = 48+1,
  osPriorityRealtime2 = 48+2,
  osPriorityRealtime3 = 48+3,
  osPriorityRealtime4 = 48+4,
  osPriorityRealtime5 = 48+5,
  osPriorityRealtime6 = 48+6,
  osPriorityRealtime7 = 48+7,
  osPriorityISR = 56,
  osPriorityError = -1,
  osPriorityReserved = 0x7FFFFFFF
} osPriority_t;


typedef void (*osThreadFunc_t) (void *argument);


typedef void (*osTimerFunc_t) (void *argument);


typedef enum {
  osTimerOnce = 0,
  osTimerPeriodic = 1
} osTimerType_t;
# 198 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
typedef enum {
  osOK = 0,
  osError = -1,
  osErrorTimeout = -2,
  osErrorResource = -3,
  osErrorParameter = -4,
  osErrorNoMemory = -5,
  osErrorISR = -6,
  osStatusReserved = 0x7FFFFFFF
} osStatus_t;



typedef void *osThreadId_t;


typedef void *osTimerId_t;


typedef void *osEventFlagsId_t;


typedef void *osMutexId_t;


typedef void *osSemaphoreId_t;


typedef void *osMemoryPoolId_t;


typedef void *osMessageQueueId_t;





typedef uint32_t TZ_ModuleId_t;




typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
  void *stack_mem;
  uint32_t stack_size;
  osPriority_t priority;
  TZ_ModuleId_t tz_module;
  uint32_t reserved;
} osThreadAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
} osTimerAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
} osEventFlagsAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
} osMutexAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
} osSemaphoreAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
  void *mp_mem;
  uint32_t mp_size;
} osMemoryPoolAttr_t;


typedef struct {
  const char *name;
  uint32_t attr_bits;
  void *cb_mem;
  uint32_t cb_size;
  void *mq_mem;
  uint32_t mq_size;
} osMessageQueueAttr_t;






osStatus_t osKernelInitialize (void);






osStatus_t osKernelGetInfo (osVersion_t *version, char *id_buf, uint32_t id_size);



osKernelState_t osKernelGetState (void);



osStatus_t osKernelStart (void);



int32_t osKernelLock (void);



int32_t osKernelUnlock (void);




int32_t osKernelRestoreLock (int32_t lock);



uint32_t osKernelSuspend (void);



void osKernelResume (uint32_t sleep_ticks);



uint32_t osKernelGetTickCount (void);



uint32_t osKernelGetTickFreq (void);



uint32_t osKernelGetSysTimerCount (void);



uint32_t osKernelGetSysTimerFreq (void);
# 371 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
osThreadId_t osThreadNew (osThreadFunc_t func, void *argument, const osThreadAttr_t *attr);




const char *osThreadGetName (osThreadId_t thread_id);



osThreadId_t osThreadGetId (void);




osThreadState_t osThreadGetState (osThreadId_t thread_id);




uint32_t osThreadGetStackSize (osThreadId_t thread_id);




uint32_t osThreadGetStackSpace (osThreadId_t thread_id);





osStatus_t osThreadSetPriority (osThreadId_t thread_id, osPriority_t priority);




osPriority_t osThreadGetPriority (osThreadId_t thread_id);



osStatus_t osThreadYield (void);




osStatus_t osThreadSuspend (osThreadId_t thread_id);




osStatus_t osThreadResume (osThreadId_t thread_id);




osStatus_t osThreadDetach (osThreadId_t thread_id);




osStatus_t osThreadJoin (osThreadId_t thread_id);


__attribute__((__noreturn__)) void osThreadExit (void);




osStatus_t osThreadTerminate (osThreadId_t thread_id);



uint32_t osThreadGetCount (void);





uint32_t osThreadEnumerate (osThreadId_t *thread_array, uint32_t array_items);
# 457 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
uint32_t osThreadFlagsSet (osThreadId_t thread_id, uint32_t flags);




uint32_t osThreadFlagsClear (uint32_t flags);



uint32_t osThreadFlagsGet (void);






uint32_t osThreadFlagsWait (uint32_t flags, uint32_t options, uint32_t timeout);







osStatus_t osDelay (uint32_t ticks);




osStatus_t osDelayUntil (uint32_t ticks);
# 497 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
osTimerId_t osTimerNew (osTimerFunc_t func, osTimerType_t type, void *argument, const osTimerAttr_t *attr);




const char *osTimerGetName (osTimerId_t timer_id);





osStatus_t osTimerStart (osTimerId_t timer_id, uint32_t ticks);




osStatus_t osTimerStop (osTimerId_t timer_id);




uint32_t osTimerIsRunning (osTimerId_t timer_id);




osStatus_t osTimerDelete (osTimerId_t timer_id);







osEventFlagsId_t osEventFlagsNew (const osEventFlagsAttr_t *attr);




const char *osEventFlagsGetName (osEventFlagsId_t ef_id);





uint32_t osEventFlagsSet (osEventFlagsId_t ef_id, uint32_t flags);





uint32_t osEventFlagsClear (osEventFlagsId_t ef_id, uint32_t flags);




uint32_t osEventFlagsGet (osEventFlagsId_t ef_id);







uint32_t osEventFlagsWait (osEventFlagsId_t ef_id, uint32_t flags, uint32_t options, uint32_t timeout);




osStatus_t osEventFlagsDelete (osEventFlagsId_t ef_id);







osMutexId_t osMutexNew (const osMutexAttr_t *attr);




const char *osMutexGetName (osMutexId_t mutex_id);





osStatus_t osMutexAcquire (osMutexId_t mutex_id, uint32_t timeout);




osStatus_t osMutexRelease (osMutexId_t mutex_id);




osThreadId_t osMutexGetOwner (osMutexId_t mutex_id);




osStatus_t osMutexDelete (osMutexId_t mutex_id);
# 610 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
osSemaphoreId_t osSemaphoreNew (uint32_t max_count, uint32_t initial_count, const osSemaphoreAttr_t *attr);




const char *osSemaphoreGetName (osSemaphoreId_t semaphore_id);





osStatus_t osSemaphoreAcquire (osSemaphoreId_t semaphore_id, uint32_t timeout);




osStatus_t osSemaphoreRelease (osSemaphoreId_t semaphore_id);




uint32_t osSemaphoreGetCount (osSemaphoreId_t semaphore_id);




osStatus_t osSemaphoreDelete (osSemaphoreId_t semaphore_id);
# 646 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
osMemoryPoolId_t osMemoryPoolNew (uint32_t block_count, uint32_t block_size, const osMemoryPoolAttr_t *attr);




const char *osMemoryPoolGetName (osMemoryPoolId_t mp_id);





void *osMemoryPoolAlloc (osMemoryPoolId_t mp_id, uint32_t timeout);





osStatus_t osMemoryPoolFree (osMemoryPoolId_t mp_id, void *block);




uint32_t osMemoryPoolGetCapacity (osMemoryPoolId_t mp_id);




uint32_t osMemoryPoolGetBlockSize (osMemoryPoolId_t mp_id);




uint32_t osMemoryPoolGetCount (osMemoryPoolId_t mp_id);




uint32_t osMemoryPoolGetSpace (osMemoryPoolId_t mp_id);




osStatus_t osMemoryPoolDelete (osMemoryPoolId_t mp_id);
# 698 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/Include\\cmsis_os2.h"
osMessageQueueId_t osMessageQueueNew (uint32_t msg_count, uint32_t msg_size, const osMessageQueueAttr_t *attr);




const char *osMessageQueueGetName (osMessageQueueId_t mq_id);







osStatus_t osMessageQueuePut (osMessageQueueId_t mq_id, const void *msg_ptr, uint8_t msg_prio, uint32_t timeout);







osStatus_t osMessageQueueGet (osMessageQueueId_t mq_id, void *msg_ptr, uint8_t *msg_prio, uint32_t timeout);




uint32_t osMessageQueueGetCapacity (osMessageQueueId_t mq_id);




uint32_t osMessageQueueGetMsgSize (osMessageQueueId_t mq_id);




uint32_t osMessageQueueGetCount (osMessageQueueId_t mq_id);




uint32_t osMessageQueueGetSpace (osMessageQueueId_t mq_id);




osStatus_t osMessageQueueReset (osMessageQueueId_t mq_id);




osStatus_t osMessageQueueDelete (osMessageQueueId_t mq_id);
# 3 "../../usr_app/usr_app.c" 2
# 1 "../../usr_app/c_shell.h" 1
# 18 "../../usr_app/c_shell.h"
# 1 "../../usr_app/c_shell_cfg.h" 1
# 19 "../../usr_app/c_shell.h" 2
# 55 "../../usr_app/c_shell.h"
typedef struct shell_obj shell_obj_t;
typedef struct shell_command shell_command_t;
struct shell_command {
    const char *name;
    const char *desc;
    union {
        void (*pfn );
        void (*pfnMain ) (shell_obj_t *, char argc, char *argv[]);
        void (*pfnKey ) (shell_obj_t *);
    };

    int32_t nKeyCode;

    enum {
        SHELL_COMMAND_FN_PTR_MAIN = 1,
        SHELL_COMMAND_FN_PTR_KEY,
    } tType;

};

typedef struct shell_cfg shell_cfg_t;
struct shell_cfg {
    uint32_t ( *read )(char *buffer, uint32_t wSize);
    uint32_t ( *write )(const char *buffer, uint32_t wSize);
    _Bool ( *login )(const char *username, const char *password);
    void ( *lock )(void *sh);
    void ( *unlock )(void *sh);

    char *username;
    char *buffer;
    int32_t nBufferSize;





};

typedef struct shell_obj shell_obj_t;
struct shell_obj {
    uint32_t ( *read )(char *buffer, uint32_t wSize);
    uint32_t ( *write )(const char *buffer, uint32_t wSize);
    _Bool ( *login )(const char *username, const char *password);

    void ( *lock )(void *sh);
    void ( *unlock )(void *sh);

    char username[16];

    const shell_command_t *ptBase;
    int32_t nCommandNumber;

    int32_t nControlCode;

    char *buffer;
    int32_t nBufferSize;
    int32_t nLength;
    int32_t nCursor;
# 123 "../../usr_app/c_shell.h"
    char *argv[3];
    char argc;

    _Bool bIsOverlayInsert;
    _Bool bInited;
    _Bool bIsLogin;

};



extern void shell_init(shell_obj_t *sh, shell_cfg_t *ptCfg);
extern void shell_task(shell_obj_t *sh);
extern void shell_write(const shell_obj_t *sh, const char *buffer, int32_t nSize);
# 4 "../../usr_app/usr_app.c" 2
# 1 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 1 3
# 58 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) void *memcpy(void * __restrict ,
                    const void * __restrict , size_t ) __attribute__((__nonnull__(1,2)));






extern __attribute__((__nothrow__)) void *memmove(void * ,
                    const void * , size_t ) __attribute__((__nonnull__(1,2)));
# 77 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strcpy(char * __restrict , const char * __restrict ) __attribute__((__nonnull__(1,2)));






extern __attribute__((__nothrow__)) char *strncpy(char * __restrict , const char * __restrict , size_t ) __attribute__((__nonnull__(1,2)));
# 93 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strcat(char * __restrict , const char * __restrict ) __attribute__((__nonnull__(1,2)));






extern __attribute__((__nothrow__)) char *strncat(char * __restrict , const char * __restrict , size_t ) __attribute__((__nonnull__(1,2)));
# 117 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) int memcmp(const void * , const void * , size_t ) __attribute__((__nonnull__(1,2)));







extern __attribute__((__nothrow__)) int strcmp(const char * , const char * ) __attribute__((__nonnull__(1,2)));






extern __attribute__((__nothrow__)) int strncmp(const char * , const char * , size_t ) __attribute__((__nonnull__(1,2)));
# 141 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) int strcasecmp(const char * , const char * ) __attribute__((__nonnull__(1,2)));







extern __attribute__((__nothrow__)) int strncasecmp(const char * , const char * , size_t ) __attribute__((__nonnull__(1,2)));
# 158 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) int strcoll(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 169 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) size_t strxfrm(char * __restrict , const char * __restrict , size_t ) __attribute__((__nonnull__(2)));
# 193 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) void *memchr(const void * , int , size_t ) __attribute__((__nonnull__(1)));
# 209 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strchr(const char * , int ) __attribute__((__nonnull__(1)));
# 218 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) size_t strcspn(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 232 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strpbrk(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 247 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strrchr(const char * , int ) __attribute__((__nonnull__(1)));
# 257 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) size_t strspn(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 270 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strstr(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 280 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) char *strtok(char * __restrict , const char * __restrict ) __attribute__((__nonnull__(2)));
extern __attribute__((__nothrow__)) char *_strtok_r(char * , const char * , char ** ) __attribute__((__nonnull__(2,3)));
# 321 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) void *memset(void * , int , size_t ) __attribute__((__nonnull__(1)));





extern __attribute__((__nothrow__)) char *strerror(int );







extern __attribute__((__nothrow__)) size_t strlen(const char * ) __attribute__((__nonnull__(1)));






extern __attribute__((__nothrow__)) size_t strlcpy(char * , const char * , size_t ) __attribute__((__nonnull__(1,2)));
# 362 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) size_t strlcat(char * , const char * , size_t ) __attribute__((__nonnull__(1,2)));
# 388 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\string.h" 3
extern __attribute__((__nothrow__)) void _membitcpybl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitcpybb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitcpyhl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitcpyhb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitcpywl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitcpywb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovebl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovebb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovehl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovehb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovewl(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) void _membitmovewb(void * , const void * , int , int , size_t ) __attribute__((__nonnull__(1,2)));
# 5 "../../usr_app/usr_app.c" 2

# 1 "../../usr_app/../bsp/uart/uart.h" 1
# 24 "../../usr_app/../bsp/uart/uart.h"
# 1 "../../usr_app/../bsp/uart/..\\bsp_cfg.h" 1
# 25 "../../usr_app/../bsp/uart/uart.h" 2
# 65 "../../usr_app/../bsp/uart/uart.h"
typedef struct {
    uint32_t wBaudrate;
    uint8_t chParity;
    uint8_t chDataWidth;
    uint8_t chStopBits;
    uint8_t chFlowControl;
    uint8_t chMode;
}uart_config_t;

typedef struct {
    uint8_t chPort;
    uart_config_t tConfig;
    void *pPrivData;
}uart_dev_t;

typedef void (*uart_func_t)(void *parameter, uint8_t *pchBuf, uint16_t hwLength);
# 97 "../../usr_app/../bsp/uart/uart.h"
extern int32_t xhal_uart_init(uart_dev_t *uart);
extern int32_t xhal_uart_send_in_dma_mode(uart_dev_t *ptUartDev, const void *pData, uint32_t wSize, uint32_t wTimeout);
extern int32_t xhal_uart_recv_in_dma_mode(uart_dev_t *ptUartDev, uint8_t *pDst, uint32_t wBytes, uint32_t wTimeout);
extern uint32_t xhal_uart_get_rx_count(uart_dev_t* ptDev);
extern int32_t xhal_uart_deinit(uart_dev_t *ptDev);
# 7 "../../usr_app/usr_app.c" 2

extern const int32_t g_nShellCommandNumber;
extern const shell_command_t g_tShellCommands[];

shell_obj_t g_tShell;
char buffer[1024];

uart_dev_t tDev = {
    .chPort = 0,
    .tConfig = {
        .wBaudrate = 115200,
        .chParity = 0,
        .chDataWidth = 3,
        .chStopBits = 0,
        .chFlowControl = 0,
        .chMode = 2
    }
};

uint32_t read(char *buffer, uint32_t wSize)
{
    return xhal_uart_recv_in_dma_mode(&tDev, (uint8_t *)buffer, wSize, 50);
}

uint32_t write(const char *buffer, uint32_t wSize)
{
    return xhal_uart_send_in_dma_mode(&tDev, buffer, wSize, 100);
}

_Bool user_login(const char *u, const char *p)
{
    return 1;
}

void myUART_Thread(void* args)
{

    xhal_uart_init(&tDev);

    shell_cfg_t tCfg = {
        .read = read,
        .write = write,

        .nBufferSize = sizeof(buffer),
        .buffer = buffer,

        .username = "admin",
        .login = user_login,






        .lock = 0,
        .unlock = 0,
    };

    shell_init(&g_tShell, &tCfg);

    while (1){
        shell_task(&g_tShell);
# 77 "../../usr_app/usr_app.c"
    }
}

void app_entry(void)
{
    osKernelInitialize();
    osThreadNew(myUART_Thread, 0, 0);
    osKernelStart();
}

int stdout_putchar(char c)
{
    return 0;
}
