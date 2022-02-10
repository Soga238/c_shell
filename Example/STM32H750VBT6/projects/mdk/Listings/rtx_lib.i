# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 374 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "./RTE/_Target_1\\Pre_Include_Global.h" 1
# 2 "<built-in>" 2
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c" 2
# 26 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include\\cmsis_compiler.h" 1
# 28 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include\\cmsis_compiler.h"
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
# 29 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include\\cmsis_compiler.h" 2
# 47 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include\\cmsis_compiler.h"
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 1
# 31 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
# 64 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

 struct __attribute__((packed)) T_UINT32 { uint32_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

 struct __attribute__((packed, aligned(1))) T_UINT16_WRITE { uint16_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

 struct __attribute__((packed, aligned(1))) T_UINT16_READ { uint16_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

 struct __attribute__((packed, aligned(1))) T_UINT32_WRITE { uint32_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

 struct __attribute__((packed, aligned(1))) T_UINT32_READ { uint32_t v; };
#pragma clang diagnostic pop
# 260 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __ROR(uint32_t op1, uint32_t op2)
{
  op2 %= 32U;
  if (op2 == 0U)
  {
    return op1;
  }
  return (op1 >> op2) | (op1 << (32U - op2));
}
# 295 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint8_t __CLZ(uint32_t value)
{
# 306 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
  if (value == 0U)
  {
    return 32U;
  }
  return __builtin_clz(value);
}
# 425 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __RRX(uint32_t value)
{
  uint32_t result;

  __asm volatile ("rrx %0, %1" : "=r" (result) : "r" (value) );
  return(result);
}
# 440 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint8_t __LDRBT(volatile uint8_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrbt %0, %1" : "=r" (result) : "Q" (*ptr) );
  return ((uint8_t) result);
}
# 455 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint16_t __LDRHT(volatile uint16_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrht %0, %1" : "=r" (result) : "Q" (*ptr) );
  return ((uint16_t) result);
}
# 470 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __LDRT(volatile uint32_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrt %0, %1" : "=r" (result) : "Q" (*ptr) );
  return(result);
}
# 485 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRBT(uint8_t value, volatile uint8_t *ptr)
{
  __asm volatile ("strbt %1, %0" : "=Q" (*ptr) : "r" ((uint32_t)value) );
}
# 497 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRHT(uint16_t value, volatile uint16_t *ptr)
{
  __asm volatile ("strht %1, %0" : "=Q" (*ptr) : "r" ((uint32_t)value) );
}
# 509 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRT(uint32_t value, volatile uint32_t *ptr)
{
  __asm volatile ("strt %1, %0" : "=Q" (*ptr) : "r" (value) );
}
# 737 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __enable_irq(void)
{
  __asm volatile ("cpsie i" : : : "memory");
}
# 750 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __disable_irq(void)
{
  __asm volatile ("cpsid i" : : : "memory");
}
# 762 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_CONTROL(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, control" : "=r" (result) );
  return(result);
}
# 792 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_CONTROL(uint32_t control)
{
  __asm volatile ("MSR control, %0" : : "r" (control) : "memory");
  __builtin_arm_isb(0xF);
}
# 818 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_IPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, ipsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_APSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, apsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_xPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, xpsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_PSP(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, psp" : "=r" (result) );
  return(result);
}
# 890 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_PSP(uint32_t topOfProcStack)
{
  __asm volatile ("MSR psp, %0" : : "r" (topOfProcStack) : );
}
# 914 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_MSP(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, msp" : "=r" (result) );
  return(result);
}
# 944 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_MSP(uint32_t topOfMainStack)
{
  __asm volatile ("MSR msp, %0" : : "r" (topOfMainStack) : );
}
# 995 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_PRIMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, primask" : "=r" (result) );
  return(result);
}
# 1025 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_PRIMASK(uint32_t priMask)
{
  __asm volatile ("MSR primask, %0" : : "r" (priMask) : "memory");
}
# 1053 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __enable_fault_irq(void)
{
  __asm volatile ("cpsie f" : : : "memory");
}







__attribute__((always_inline)) static __inline void __disable_fault_irq(void)
{
  __asm volatile ("cpsid f" : : : "memory");
}







__attribute__((always_inline)) static __inline uint32_t __get_BASEPRI(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, basepri" : "=r" (result) );
  return(result);
}
# 1105 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_BASEPRI(uint32_t basePri)
{
  __asm volatile ("MSR basepri, %0" : : "r" (basePri) : "memory");
}
# 1130 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_BASEPRI_MAX(uint32_t basePri)
{
  __asm volatile ("MSR basepri_max, %0" : : "r" (basePri) : "memory");
}







__attribute__((always_inline)) static __inline uint32_t __get_FAULTMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, faultmask" : "=r" (result) );
  return(result);
}
# 1171 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_FAULTMASK(uint32_t faultMask)
{
  __asm volatile ("MSR faultmask, %0" : : "r" (faultMask) : "memory");
}
# 1491 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include/cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline int32_t __SMMLA (int32_t op1, int32_t op2, int32_t op3)
{
  int32_t result;

  __asm volatile ("smmla %0, %1, %2, %3" : "=r" (result): "r" (op1), "r" (op2), "r" (op3) );
  return(result);
}
# 48 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/Core/Include\\cmsis_compiler.h" 2
# 27 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c" 2
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h" 1
# 30 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h"
# 1 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 1 3
# 38 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
  typedef signed int ptrdiff_t;
# 53 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
    typedef unsigned int size_t;
# 71 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
      typedef unsigned short wchar_t;
# 95 "D:\\Keil_v5\\ARM\\ARMCLANG\\Bin\\..\\include\\stddef.h" 3
  typedef long double max_align_t;
# 31 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h" 2
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
# 32 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h" 2
# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include/rtx_def.h" 1
# 18 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include/rtx_def.h"
# 1 "./RTE/_Target_1\\RTE_Components.h" 1
# 19 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include/rtx_def.h" 2

# 1 "./RTE/CMSIS\\RTX_Config.h" 1
# 21 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include/rtx_def.h" 2
# 33 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h" 2
# 103 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h"
typedef struct osRtxThread_s {
  uint8_t id;
  uint8_t state;
  uint8_t flags;
  uint8_t attr;
  const char *name;
  struct osRtxThread_s *thread_next;
  struct osRtxThread_s *thread_prev;
  struct osRtxThread_s *delay_next;
  struct osRtxThread_s *delay_prev;
  struct osRtxThread_s *thread_join;
  uint32_t delay;
  int8_t priority;
  int8_t priority_base;
  uint8_t stack_frame;
  uint8_t flags_options;
  uint32_t wait_flags;
  uint32_t thread_flags;
  struct osRtxMutex_s *mutex_list;
  void *stack_mem;
  uint32_t stack_size;
  uint32_t sp;
  uint32_t thread_addr;
  uint32_t tz_memory;



} osRtxThread_t;
# 144 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h"
typedef struct {
  osTimerFunc_t func;
  void *arg;
} osRtxTimerFinfo_t;


typedef struct osRtxTimer_s {
  uint8_t id;
  uint8_t state;
  uint8_t flags;
  uint8_t type;
  const char *name;
  struct osRtxTimer_s *prev;
  struct osRtxTimer_s *next;
  uint32_t tick;
  uint32_t load;
  osRtxTimerFinfo_t finfo;
} osRtxTimer_t;





typedef struct {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t reserved;
  const char *name;
  osRtxThread_t *thread_list;
  uint32_t event_flags;
} osRtxEventFlags_t;





typedef struct osRtxMutex_s {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t attr;
  const char *name;
  osRtxThread_t *thread_list;
  osRtxThread_t *owner_thread;
  struct osRtxMutex_s *owner_prev;
  struct osRtxMutex_s *owner_next;
  uint8_t lock;
  uint8_t padding[3];
} osRtxMutex_t;





typedef struct {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t reserved;
  const char *name;
  osRtxThread_t *thread_list;
  uint16_t tokens;
  uint16_t max_tokens;
} osRtxSemaphore_t;





typedef struct {
  uint32_t max_blocks;
  uint32_t used_blocks;
  uint32_t block_size;
  void *block_base;
  void *block_lim;
  void *block_free;
} osRtxMpInfo_t;


typedef struct {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t reserved;
  const char *name;
  osRtxThread_t *thread_list;
  osRtxMpInfo_t mp_info;
} osRtxMemoryPool_t;





typedef struct osRtxMessage_s {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t priority;
  struct osRtxMessage_s *prev;
  struct osRtxMessage_s *next;
} osRtxMessage_t;


typedef struct {
  uint8_t id;
  uint8_t reserved_state;
  uint8_t flags;
  uint8_t reserved;
  const char *name;
  osRtxThread_t *thread_list;
  osRtxMpInfo_t mp_info;
  uint32_t msg_size;
  uint32_t msg_count;
  osRtxMessage_t *msg_first;
  osRtxMessage_t *msg_last;
} osRtxMessageQueue_t;





typedef struct {
  uint8_t id;
  uint8_t state;
  uint8_t flags;
  uint8_t reserved;
  const char *name;
  osRtxThread_t *thread_list;
} osRtxObject_t;





typedef struct {
  const char *os_id;
  uint32_t version;
  struct {
    uint8_t state;
    volatile uint8_t blocked;
    uint8_t pendSV;
    uint8_t reserved;
    uint32_t tick;
  } kernel;
  int32_t tick_irqn;
  struct {
    struct {
      osRtxThread_t *curr;
      osRtxThread_t *next;
    } run;
    osRtxObject_t ready;
    osRtxThread_t *idle;
    osRtxThread_t *delay_list;
    osRtxThread_t *wait_list;
    osRtxThread_t *terminate_list;
    uint32_t reserved;
    struct {
      osRtxThread_t *thread;
      uint32_t timeout;
    } robin;
  } thread;
  struct {
    osRtxTimer_t *list;
    osRtxThread_t *thread;
    osRtxMessageQueue_t *mq;
    void (*tick)(void);
  } timer;
  struct {
    uint16_t max;
    uint16_t cnt;
    uint16_t in;
    uint16_t out;
    void **data;
  } isr_queue;
  struct {
    void (*thread)(osRtxThread_t*);
    void (*event_flags)(osRtxEventFlags_t*);
    void (*semaphore)(osRtxSemaphore_t*);
    void (*memory_pool)(osRtxMemoryPool_t*);
    void (*message)(osRtxMessage_t*);
  } post_process;
  struct {
    void *stack;
    void *mp_data;
    void *mq_data;
    void *common;
  } mem;
  struct {
    osRtxMpInfo_t *stack;
    osRtxMpInfo_t *thread;
    osRtxMpInfo_t *timer;
    osRtxMpInfo_t *event_flags;
    osRtxMpInfo_t *mutex;
    osRtxMpInfo_t *semaphore;
    osRtxMpInfo_t *memory_pool;
    osRtxMpInfo_t *message_queue;
  } mpi;
} osRtxInfo_t;

extern osRtxInfo_t osRtxInfo;


typedef struct {
  uint32_t cnt_alloc;
  uint32_t cnt_free;
  uint32_t max_used;
} osRtxObjectMemUsage_t;


extern osRtxObjectMemUsage_t osRtxThreadMemUsage;
extern osRtxObjectMemUsage_t osRtxTimerMemUsage;
extern osRtxObjectMemUsage_t osRtxEventFlagsMemUsage;
extern osRtxObjectMemUsage_t osRtxMutexMemUsage;
extern osRtxObjectMemUsage_t osRtxSemaphoreMemUsage;
extern osRtxObjectMemUsage_t osRtxMemoryPoolMemUsage;
extern osRtxObjectMemUsage_t osRtxMessageQueueMemUsage;
# 404 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h"
extern uint32_t osRtxErrorNotify (uint32_t code, void *object_id);
extern uint32_t osRtxKernelErrorNotify (uint32_t code, void *object_id);


extern void osRtxIdleThread (void *argument);


extern void SVC_Handler (void);
extern void PendSV_Handler (void);
extern void SysTick_Handler (void);
# 429 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_os.h"
typedef struct {
  uint32_t flags;
  uint32_t tick_freq;
  uint32_t robin_timeout;
  struct {
    void **data;
    uint16_t max;
    uint16_t padding;
  } isr_queue;
  struct {
    void *stack_addr;
    uint32_t stack_size;
    void *mp_data_addr;
    uint32_t mp_data_size;
    void *mq_data_addr;
    uint32_t mq_data_size;
    void *common_addr;
    uint32_t common_size;
  } mem;
  struct {
    osRtxMpInfo_t *stack;
    osRtxMpInfo_t *thread;
    osRtxMpInfo_t *timer;
    osRtxMpInfo_t *event_flags;
    osRtxMpInfo_t *mutex;
    osRtxMpInfo_t *semaphore;
    osRtxMpInfo_t *memory_pool;
    osRtxMpInfo_t *message_queue;
  } mpi;
  uint32_t thread_stack_size;
  const
  osThreadAttr_t *idle_thread_attr;
  const
  osThreadAttr_t *timer_thread_attr;
  void (*timer_thread)(void *);
  int32_t (*timer_setup)(void);
  const
  osMessageQueueAttr_t *timer_mq_attr;
  uint32_t timer_mq_mcnt;
} osRtxConfig_t;

extern const osRtxConfig_t osRtxConfig;
# 28 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c" 2





# 1 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Include\\rtx_evr.h" 1
# 34 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c" 2
# 44 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static uint64_t os_mem[20480/8] __attribute__((section(".bss.os")));
# 57 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static void *os_isr_queue[16] __attribute__((section(".bss.os")));
# 115 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static osRtxThread_t os_idle_thread_cb __attribute__((section(".bss.os.thread.cb")));



static uint64_t os_idle_thread_stack[512/8] __attribute__((section(".bss.os.thread.idle.stack")));



static const osThreadAttr_t os_idle_thread_attr = {



  0,

  0x00000000U,
  &os_idle_thread_cb,
  (uint32_t)sizeof(os_idle_thread_cb),
  &os_idle_thread_stack[0],
  (uint32_t)sizeof(os_idle_thread_stack),
  osPriorityIdle,

  (uint32_t)0,



  0U
};
# 172 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static osRtxThread_t os_timer_thread_cb __attribute__((section(".bss.os.thread.cb")));



static uint64_t os_timer_thread_stack[512/8] __attribute__((section(".bss.os.thread.timer.stack")));



static const osThreadAttr_t os_timer_thread_attr = {



  0,

  0x00000000U,
  &os_timer_thread_cb,
  (uint32_t)sizeof(os_timer_thread_cb),
  &os_timer_thread_stack[0],
  (uint32_t)sizeof(os_timer_thread_stack),

  (osPriority_t)40,

  (uint32_t)0,



  0U
};


static osRtxMessageQueue_t os_timer_mq_cb __attribute__((section(".bss.os.msgqueue.cb")));



static uint32_t os_timer_mq_data[(4*(4)*(3+(((8)+3)/4)))/4] __attribute__((section(".bss.os.msgqueue.mem")));



static const osMessageQueueAttr_t os_timer_mq_attr = {
  0,
  0U,
  &os_timer_mq_cb,
  (uint32_t)sizeof(os_timer_mq_cb),
  &os_timer_mq_data[0],
  (uint32_t)sizeof(os_timer_mq_data)
};

extern int32_t osRtxTimerSetup (void);
extern void osRtxTimerThread (void *argument);
# 418 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
const osRtxConfig_t osRtxConfig __attribute__((used)) __attribute__((section(".rodata"))) =


{

  0U

  | (1UL<<0)


  | (1UL<<1)




  ,
  (uint32_t)1000,

  (uint32_t)5,



  { &os_isr_queue[0], (uint16_t)(sizeof(os_isr_queue)/sizeof(void *)), 0U },
  {




    0, 0U,




    0, 0U,




    0, 0U,


    &os_mem[0], (uint32_t)20480,



  },
  {
# 474 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
    0,
    0,




    0,




    0,




    0,




    0,




    0,




    0,

  },
  (uint32_t)2048,
  &os_idle_thread_attr,

  &os_timer_thread_attr,
  osRtxTimerThread,
  osRtxTimerSetup,
  &os_timer_mq_attr,
  (uint32_t)4







};






extern const uint8_t irqRtxLib;
extern const uint8_t * const irqRtxLibRef;
       const uint8_t * const irqRtxLibRef = &irqRtxLib;





extern void * const osRtxUserSVC[];
__attribute__((weak)) void * const osRtxUserSVC[1] = { (void *)0 };
# 555 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static const uint32_t __os_thread_cb_start__ __attribute__((weakref(".bss.os.thread.cb$$Base")));
static const uint32_t __os_thread_cb_end__ __attribute__((weakref(".bss.os.thread.cb$$Limit")));
static const uint32_t __os_timer_cb_start__ __attribute__((weakref(".bss.os.timer.cb$$Base")));
static const uint32_t __os_timer_cb_end__ __attribute__((weakref(".bss.os.timer.cb$$Limit")));
static const uint32_t __os_evflags_cb_start__ __attribute__((weakref(".bss.os.evflags.cb$$Base")));
static const uint32_t __os_evflags_cb_end__ __attribute__((weakref(".bss.os.evflags.cb$$Limit")));
static const uint32_t __os_mutex_cb_start__ __attribute__((weakref(".bss.os.mutex.cb$$Base")));
static const uint32_t __os_mutex_cb_end__ __attribute__((weakref(".bss.os.mutex.cb$$Limit")));
static const uint32_t __os_semaphore_cb_start__ __attribute__((weakref(".bss.os.semaphore.cb$$Base")));
static const uint32_t __os_semaphore_cb_end__ __attribute__((weakref(".bss.os.semaphore.cb$$Limit")));
static const uint32_t __os_mempool_cb_start__ __attribute__((weakref(".bss.os.mempool.cb$$Base")));
static const uint32_t __os_mempool_cb_end__ __attribute__((weakref(".bss.os.mempool.cb$$Limit")));
static const uint32_t __os_msgqueue_cb_start__ __attribute__((weakref(".bss.os.msgqueue.cb$$Base")));
static const uint32_t __os_msgqueue_cb_end__ __attribute__((weakref(".bss.os.msgqueue.cb$$Limit")));
# 587 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
extern const uint32_t * const os_cb_sections[];



const uint32_t * const os_cb_sections[] __attribute__((used)) __attribute__((section(".rodata"))) =


{
  &__os_thread_cb_start__,
  &__os_thread_cb_end__,
  &__os_timer_cb_start__,
  &__os_timer_cb_end__,
  &__os_evflags_cb_start__,
  &__os_evflags_cb_end__,
  &__os_mutex_cb_start__,
  &__os_mutex_cb_end__,
  &__os_semaphore_cb_start__,
  &__os_semaphore_cb_end__,
  &__os_mempool_cb_start__,
  &__os_mempool_cb_end__,
  &__os_msgqueue_cb_start__,
  &__os_msgqueue_cb_end__
};
# 621 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
extern void _platform_post_stackheap_init (void);
__attribute__((weak)) void _platform_post_stackheap_init (void) {
  (void)osKernelInitialize();
}
# 674 "D:/Arm/ARM/CMSIS/5.8.0/CMSIS/RTOS2/RTX/Source/rtx_lib.c"
static uint32_t os_libspace[4 +1][96/4] __attribute__((section(".bss.os.libspace")));



static osThreadId_t os_libspace_id[4] __attribute__((section(".bss.os.libspace")));



static uint32_t os_kernel_is_active (void) {
  static uint8_t os_kernel_active = 0U;

  if (os_kernel_active == 0U) {
    if (osKernelGetState() > osKernelReady) {
      os_kernel_active = 1U;
    }
  }
  return (uint32_t)os_kernel_active;
}


void *__user_perthread_libspace (void);
void *__user_perthread_libspace (void) {
  osThreadId_t id;
  uint32_t n;

  if (os_kernel_is_active() != 0U) {
    id = osThreadGetId();
    for (n = 0U; n < (uint32_t)4; n++) {
      if (os_libspace_id[n] == 0) {
        os_libspace_id[n] = id;
      }
      if (os_libspace_id[n] == id) {
        break;
      }
    }
    if (n == (uint32_t)4) {
      (void)osRtxKernelErrorNotify(4U, id);
    }
  } else {
    n = 4;
  }


  return (void *)&os_libspace[n][0];
}


typedef void *mutex;






__attribute__((used))
int _mutex_initialize(mutex *m);
int _mutex_initialize(mutex *m) {
  int result;

  *m = osMutexNew(0);
  if (*m != 0) {
    result = 1;
  } else {
    result = 0;
    (void)osRtxKernelErrorNotify(5U, m);
  }
  return result;
}


__attribute__((used))
void _mutex_acquire(mutex *m);
void _mutex_acquire(mutex *m) {
  if (os_kernel_is_active() != 0U) {
    (void)osMutexAcquire(*m, 0xFFFFFFFFU);
  }
}


__attribute__((used))
void _mutex_release(mutex *m);
void _mutex_release(mutex *m) {
  if (os_kernel_is_active() != 0U) {
    (void)osMutexRelease(*m);
  }
}


__attribute__((used))
void _mutex_free(mutex *m);
void _mutex_free(mutex *m) {
  (void)osMutexDelete(*m);
}
