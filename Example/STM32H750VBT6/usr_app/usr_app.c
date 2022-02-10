#include "Driver_USART.h"
#include "cmsis_os2.h"
#include "c_shell.h"
#include "string.h"

#include "../bsp/uart/uart.h"

extern const int32_t g_nShellCommandNumber;
extern const shell_command_t g_tShellCommands[];

shell_obj_t g_tShell;
char g_buffer[1024];

uart_dev_t tDev = {
    .chPort = PORT_UART_GSM,
    .tConfig = {
        .wBaudrate = 115200,
        .chParity = UART_NO_PARITY,
        .chDataWidth = DATA_WIDTH_8BIT,
        .chStopBits = UART_STOP_BITS_1,
        .chFlowControl = FLOW_CONTROL_DISABLED,
        .chMode = MODE_TX_RX
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

bool user_login(const char *u, const char *p)
{
//    return 0 == strcmp(p, "123456");
    return true;
}

void myUART_Thread(void* args)
{    
    int i, count;
    char recv[32];
    
    xhal_uart_init(&tDev);

    shell_cfg_t tCfg = {
#if (0)
        .read               = read, // shell_task(&sh)
#endif
        .write              = write,

        .nBufferSize        = sizeof(g_buffer),
        .buffer             = g_buffer,

        .username           = "admin",
        .login              = user_login,

#if (C_SHELL_EXPORT_COMMAND_ENABLE == 0)
        .ptBase             = g_tShellCommands,
        .nCommandNumber     = g_nShellCommandNumber,
#endif

        .lock               = NULL,
        .unlock             = NULL,
    };
 
    shell_init(&g_tShell, &tCfg);

    while (1){
        count = read(recv, sizeof(recv));
        for (i = 0; i < count; ++i) {
            shell_task_on_callback(&g_tShell, recv[i]);
        }
    }
}

void app_entry(void)
{
    osKernelInitialize();
    osThreadNew(myUART_Thread, NULL, NULL);
    osKernelStart();
}

int stdout_putchar(char c)
{
    return 0;
}