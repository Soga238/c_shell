/****************************************************************************
 * Copyright (c) [2021] [Soga] [core.zhang@outlook.com]                     *
 * [] is licensed under Mulan PSL v2.                                       *
 * You can use this software according to the terms and conditions of       *
 * the Mulan PSL v2.                                                        *
 * You may obtain a copy of Mulan PSL v2 at:                                *
 *          http://license.coscl.org.cn/MulanPSL2                           *
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF     *
 * ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO        *
 * NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.       *
 * See the Mulan PSL v2 for more details.                                   *
 *                                                                          *
 ***************************************************************************/
/* Includes --------------------------------------------------------*/
#include "stdio.h"
#include "c_shell.h"

/* Global variables ------------------------------------------------*/
extern const int32_t g_nShellCommandNumber;
const shell_command_t g_tShellCommands[];

/* Private typedef -------------------------------------------------*/
/* Private define --------------------------------------------------*/
/* Private macro ---------------------------------------------------*/
/* Private variables -----------------------------------------------*/
/* Private function prototypes -------------------------------------*/
/* Private functions -----------------------------------------------*/
void shell_init(shell_obj_t *sh, char *buffer, int32_t nBufferSize)
{
    sh->ptBase = g_tShellCommands;
    sh->nCommandNumber = g_nShellCommandNumber;

    sh->buffer = buffer;
    sh->nBufferSize = nBufferSize;
}

static void shell_write(shell_obj_t *sh, char *buffer)
{
    printf("%s", buffer);
}

static void echo_prompt(shell_obj_t *sh, unsigned char newline)
{
    shell_write(sh, sh->username);
    shell_write(sh, ":/$");
}

void shell_handler(shell_obj_t *sh, char data)
{
    const shell_command_t *ptCmd;

    /*! 遍历执行按键函数 */
    for (int32_t i = 0; i < sh->nCommandNumber; ++i) {
        ptCmd = sh->ptBase + i;
        if (ptCmd->tType != SHELL_COMMAND_FN_PTR_KEY) {
            continue;
        }
    }

    printf("%d", data);
}

/*************************** End of file ****************************/
