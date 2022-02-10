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
#include "c_shell.h"
#include "string.h"

/* Global variables ------------------------------------------------*/
void ls(shell_obj_t *sh, int argc, char *argv[]);

const int32_t g_nShellCommandNumber = 1;
const shell_command_t g_tShellCommands[1] = {
    {
        .tType = SHELL_COMMAND_FN_PTR_MAIN,
        .name = "ls",
        .desc = "ls",
        .pfn = ls,
    },
};

/* Private typedef -------------------------------------------------*/
/* Private define --------------------------------------------------*/
/* Private macro ---------------------------------------------------*/
/* Private variables -----------------------------------------------*/
/* Private function prototypes -------------------------------------*/
/* Private functions -----------------------------------------------*/

void ls(shell_obj_t *sh, int argc, char *argv[])
{
    shell_write(sh, "\r\nThis is ls", sizeof("\r\nThis is ls"));
    for (int i = 1; i < argc; ++i) {
        shell_write(sh, argv[i], (int32_t)strlen(argv[i]));
    }
}

void test_func(shell_obj_t *sh, int argc, char *argv[])
{
    shell_write(sh, "\r\nfunc test", sizeof("\r\nfunc test"));
}

C_SHELL_EXPORT_COMMAND(test_func, test_func, 0, test_func);

void test_func2(shell_obj_t *sh, int argc, char *argv[])
{
    shell_write(sh, "\r\nfunc test2", sizeof("\r\nfunc test2"));
}

C_SHELL_EXPORT_COMMAND(test_func2, test_func2, 0, test_func2);
/*************************** End of file ****************************/
