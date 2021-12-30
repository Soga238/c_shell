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
#include "string.h"
#include "stdio.h"
#include "c_shell.h"

/* Global variables ------------------------------------------------*/
/* Private typedef -------------------------------------------------*/
enum shell_ret_t {
    SHELL_COMMAND_NOT_FOUND = 0,
    SHELL_COMMAND_PARAM_TOO_LONG,
};

/* Private define --------------------------------------------------*/
/* Private macro ---------------------------------------------------*/
#ifndef UNUSED_PARAM
#define UNUSED_PARAM(__PARAM)   (void)(__PARAM)
#endif

#ifndef COUNT_OF
#define COUNT_OF(__ARR) (sizeof(__ARR)/sizeof((__ARR)[0]))
#endif

/* Private variables -----------------------------------------------*/
#if (SHELL_SHOW_INFORMATION == 1)
static const char *c_information =
    "\r\n"
    "  _____    _____ _    _ ______ _      _\r\n"
    " / ____|  / ____| |  | |  ____| |    | |\r\n"
    "| |      | (___ | |__| | |__  | |    | |\r\n"
    "| |       \\___ \\|  __  |  __| | |    | |\r\n"
    "| |____   ____) | |  | | |____| |____| |____\r\n"
    " \\_____| |_____/|_|  |_|______|______|______|\r\n"
    "Build:\t\t"__DATE__" "__TIME__"\r\n"
    "Version:\t"C_SHELL_VERSION"\r\n"
    "Copyright:\thttps://github.com/Soga238/c_shell\r\n";
#endif

static void on_key_enter(shell_obj_t *sh);
static void on_key_insert(shell_obj_t *sh);
static void on_key_up_arrow(shell_obj_t *sh);
static void on_key_down_arrow(shell_obj_t *sh);
static void on_key_right_arrow(shell_obj_t *sh);
static void on_key_left_arrow(shell_obj_t *sh);
static void on_key_backspace(shell_obj_t *sh);

static void on_command_list_all(shell_obj_t *sh, char argc, char *argv[]);
static void on_command_clear(shell_obj_t *sh, char argc, char *argv[]);

static const shell_command_t s_tCommands[9] = {
    {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Enter",
        .pfn = on_key_enter,
        .nKeyCode = 0x0d
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Backspace",
        .pfn = on_key_backspace,
        .nKeyCode = 0x08
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Up",
        .pfn = on_key_up_arrow,
        .nKeyCode = 0x001B5B41
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Down",
        .pfn = on_key_down_arrow,
        .nKeyCode = 0x001B5B42
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Left",
        .pfn = on_key_left_arrow,
        .nKeyCode = 0x001B5B44
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Right",
        .pfn = on_key_right_arrow,
        .nKeyCode = 0x001B5B43
    }, {
        .tType = SHELL_COMMAND_FN_PTR_KEY,
        .name = "Insert",
        .pfn = on_key_insert,
        .nKeyCode = 0x1B5B327E
    }, {
        .tType = SHELL_COMMAND_FN_PTR_MAIN,
        .name = "cmds",
        .pfn = on_command_list_all,
    }, {
        .tType = SHELL_COMMAND_FN_PTR_MAIN,
        .name = "clear",
        .pfn = on_command_clear,
    },
};

/* Private function prototypes -------------------------------------*/
/* Private functions -----------------------------------------------*/
static inline void write_string(const shell_obj_t *sh, const char *buffer)
{
    sh->write(buffer, strlen(buffer));
}

static inline void write_bytes(const shell_obj_t *sh, const char *buffer, uint32_t wSize)
{
    sh->write(buffer, wSize);
}

const char *error_text(enum shell_ret_t tRet)
{
    switch (tRet) {
        case SHELL_COMMAND_NOT_FOUND:return "\r\nCommand not found\r\n";
        case SHELL_COMMAND_PARAM_TOO_LONG:return "\r\nCommand param too long\r\n";
        default:break;
    }
    return "";
}

static void echo_prompt(const shell_obj_t *sh)
{
    write_string(sh, "\r\n");
    write_string(sh, sh->username);
    write_bytes(sh, ":/$", 2);
}

static void parse_argv(shell_obj_t *sh)
{
    char *token;

    /*! strtok is not thread safety*/

    if (NULL != sh->lock) {
        sh->lock(sh);
    }

    sh->argc = 0;
    token = strtok(sh->buffer, " ");

    do {
        sh->argv[sh->argc++] = token;
        token = strtok(NULL, " ");
    } while (token && (sh->argc < COUNT_OF(sh->argv)));

    if (NULL != sh->unlock) {
        sh->unlock(sh);
    }
}

static const shell_command_t *get_command(const char *name,
                                          const shell_command_t *ptBuffer,
                                          int32_t nSize)
{
    const shell_command_t *ptCmd;
    const char *_name;

    for (int32_t i = 0; i < nSize; ++i) {
        ptCmd = ptBuffer + i;
        if (ptCmd->tType == SHELL_COMMAND_FN_PTR_MAIN) {
            _name = ptCmd->name != NULL ? ptCmd->name : "";
            if (0 == strcmp(name, _name)) {
                return ptCmd;
            }
        }
    }

    return NULL;
}

static void execute_main_command(shell_obj_t *sh)
{
    const shell_command_t *ptCmd;
    bool bFound = false;

    if (sh->nLength == 0) {
        return;
    }

    sh->buffer[sh->nLength] = 0;

    parse_argv(sh);

    ptCmd = get_command(sh->argv[0], s_tCommands, COUNT_OF(s_tCommands));
    if (NULL == ptCmd && NULL != sh->ptBase) {
        ptCmd = get_command(sh->argv[0], sh->ptBase, sh->nCommandNumber);
    }

    if (NULL != ptCmd) {
        ptCmd->pfnMain(sh, sh->argc, sh->argv);
        bFound = true;
    }

    sh->nCursor = sh->nLength = 0;

    if (!bFound) {
        write_string(sh, error_text(SHELL_COMMAND_NOT_FOUND));
    }
}

static bool execute_key_command(shell_obj_t *sh, int32_t nKeyCode)
{
    const shell_command_t *ptCmd;
    int32_t i, nMask;

    /*! 遍历执行按键函数 */
    for (i = 0; i < COUNT_OF(s_tCommands); ++i) {
        ptCmd = &s_tCommands[i];
        if (ptCmd->tType != SHELL_COMMAND_FN_PTR_KEY) {
            continue;
        }

        for (char j = 0; j < 4; ++j) {
            nMask = (int32_t) (0xFFFFFFFF >> (8 * j)) & nKeyCode;
            if (ptCmd->nKeyCode == nMask && ptCmd->pfnKey) {
                ptCmd->pfnKey(sh);
                return true;
            }
        }
    }

    return false;
}

static void on_key_up_arrow(shell_obj_t *sh)
{
    UNUSED_PARAM(sh);
}

static void on_key_down_arrow(shell_obj_t *sh)
{
    UNUSED_PARAM(sh);
}

static void on_key_right_arrow(shell_obj_t *sh)
{
    if (sh->nCursor < sh->nLength) {
        write_bytes(sh, &sh->buffer[sh->nCursor++], 1);
    }
}

static void on_key_left_arrow(shell_obj_t *sh)
{
    if (sh->nCursor > 0) {
        sh->nCursor -= 1;
        write_bytes(sh, "\b", 1);
    }
}

static bool login_required(shell_obj_t *sh)
{
    if (!sh->bIsLogin) {
        sh->bIsLogin = (NULL != sh->login) ? sh->login(sh->username, sh->buffer) : true;
        sh->nCursor = sh->nLength = 0;
        if (sh->bIsLogin) {
#if (SHELL_SHOW_INFORMATION == 1)
            write_string(sh, c_information);
#endif
        } else {
            write_string(sh, "\r\nInput password:");
        }
    }

    return sh->bIsLogin;
}

static void on_key_enter(shell_obj_t *sh)
{
    if (login_required(sh)) {
        execute_main_command(sh);
        echo_prompt(sh);
    }
}

static void on_key_insert(shell_obj_t *sh)
{
    sh->bIsOverlayInsert = !sh->bIsOverlayInsert;
}

static void on_key_backspace(shell_obj_t *sh)
{
    const char buf[10] = "\b\b\b\b\b\b\b\b\b\b";
    volatile int32_t i;

    if (sh->nCursor > 0) {
        write_bytes(sh, "\b", 1);
        write_bytes(sh, sh->buffer + sh->nCursor, sh->nLength - sh->nCursor);
        write_bytes(sh, " ", 1);

        i = (sh->nLength - sh->nCursor + 1) / 10;
        while (i-- > 0) {
            write_bytes(sh, buf, 10);
        }

        i = (sh->nLength - sh->nCursor + 1) % 10;
        write_bytes(sh, buf, i);

        sh->nCursor -= 1;
        sh->nLength -= 1;

        for (i = sh->nCursor; i < sh->nLength; ++i) {
            sh->buffer[i] = sh->buffer[i + 1];
        }

        sh->buffer[sh->nLength] = 0;
    }
}

static void on_command_list_all(shell_obj_t *sh, char argc, char *argv[])
{
    UNUSED_PARAM(argc);
    UNUSED_PARAM(argv);

    const shell_command_t *ptCmd;

    write_bytes(sh, "\r\ncommands:\r\n", 13);
    for (int32_t i = 0; i < COUNT_OF(s_tCommands); ++i) {
        ptCmd = s_tCommands + i;
        if (ptCmd->tType == SHELL_COMMAND_FN_PTR_MAIN) {
            write_bytes(sh, "\t+ ", 3);
            write_string(sh, ptCmd->name ? ptCmd->name : "");
            write_bytes(sh, ":\t", 2);
            write_string(sh, ptCmd->desc ? ptCmd->desc : "");
            write_bytes(sh, "\r\n", 2);
        }
    }
    for (int32_t i = 0; i < sh->nCommandNumber && NULL != sh->ptBase; ++i) {
        ptCmd = sh->ptBase + i;
        if (ptCmd->tType == SHELL_COMMAND_FN_PTR_MAIN) {
            write_bytes(sh, "\t+ ", 3);
            write_string(sh, ptCmd->name ? ptCmd->name : "");
            write_bytes(sh, ":\t", 2);
            write_string(sh, ptCmd->desc ? ptCmd->desc : "");
            write_bytes(sh, "\r\n", 2);
        }
    }
}

static void on_command_clear(shell_obj_t *sh, char argc, char *argv[])
{
    UNUSED_PARAM(argc);
    UNUSED_PARAM(argv);

    write_string(sh, "\033[2J\033[1H");
}

static void normal_key_code_overlay_insert(shell_obj_t *sh, char c)
{
    /*! 在输入的尾部插入 */
    if (sh->nCursor == sh->nLength) {
        if ((sh->nLength + 1) < sh->nBufferSize) {
            sh->buffer[sh->nLength] = c;
            sh->nLength += 1;
            sh->nCursor += 1;
            sh->buffer[sh->nLength] = 0;
            write_bytes(sh, &c, 1);
        }
    } else {
        /*! 覆盖插入 */
        sh->buffer[sh->nCursor++] = c;
        write_bytes(sh, &c, 1);
    }
}

static void normal_key_code_insert(shell_obj_t *sh, char c)
{
    const char buf[10] = "\b\b\b\b\b\b\b\b\b\b";
    volatile int32_t i;

    /*! 尾部保留一个字节填充 0 */
    if ((sh->nLength + 1) >= sh->nBufferSize) {
        return;
    }

    /*! 在输入的尾部插入 */
    if (sh->nCursor == sh->nLength) {
        sh->buffer[sh->nLength] = c;
        sh->nLength += 1;
        sh->nCursor += 1;
        sh->buffer[sh->nLength] = 0;
        write_bytes(sh, &c, 1);
    } else {
        /*! 插入退格 */
        for (i = sh->nLength; i > sh->nCursor; --i) {
            sh->buffer[i] = sh->buffer[i - 1];
        }

        sh->buffer[sh->nCursor] = c;
        sh->buffer[sh->nLength + 1] = 0;
        sh->nLength += 1;
        sh->nCursor += 1;
        //        sh->buffer[sh->nLength] = 0;

        i = sh->nLength - sh->nCursor;
        write_bytes(sh, sh->buffer + sh->nCursor - 1, i + 1);

        /*! 减少传送次数 */
        i = (sh->nLength - sh->nCursor) / 10;
        while (i-- > 0) {
            write_bytes(sh, buf, 10);
        }

        i = (sh->nLength - sh->nCursor) % 10;
        write_bytes(sh, buf, i);
    }
}

static bool is_control_code_sequence(int32_t nKeyCode)
{
    volatile union {
        struct {
            uint8_t a;
            uint8_t b;
            uint8_t c;
            uint8_t d;
        };
        int32_t nValue;
    } tUn = {.nValue = nKeyCode};

    return tUn.a == 0x1B || tUn.b == 0x1B || tUn.c == 0x1B || tUn.d == 0x1B;
}

static void shell_handler(shell_obj_t *sh, char c)
{
    /*! 记录键盘控制码 */
    sh->nControlCode <<= 8;
    sh->nControlCode |= c;

    /*! 遍历执行按键函数 */
    if (execute_key_command(sh, sh->nControlCode)) {
        sh->nControlCode = 0;
    } else if (!is_control_code_sequence(sh->nControlCode)) {
        if (sh->bIsOverlayInsert) {
            normal_key_code_overlay_insert(sh, c);
        } else {
            normal_key_code_insert(sh, c);
        }
    }
}

void shell_task(shell_obj_t *sh)
{
    uint32_t wCount, i;
    char buffer[32];

    if (NULL != sh && sh->bInited) {
        wCount = sh->read(buffer, sizeof(buffer));
        for (i = 0; i < wCount; ++i) {
            shell_handler(sh, buffer[i]);
        }
    }
}

void shell_write(const shell_obj_t *sh, const char *buffer, int32_t nSize)
{
    if (NULL != sh && NULL != sh->write) {
        sh->write(buffer, nSize);
    }
}

void shell_init(shell_obj_t *sh, shell_cfg_t *ptCfg)
{
    if (NULL != sh) {
        sh->bInited = false;

        if (NULL == ptCfg ||
            NULL == ptCfg->read || NULL == ptCfg->write ||
            NULL == ptCfg->buffer || 0 == ptCfg->nBufferSize) {
            return;
        }

        if (NULL != ptCfg->username) {
            snprintf(sh->username, sizeof(sh->username), "%s", ptCfg->username);
        }

        sh->ptBase = ptCfg->ptBase;
        sh->nCommandNumber = ptCfg->nCommandNumber;

        sh->write = ptCfg->write;
        sh->read = ptCfg->read;
        sh->login = ptCfg->login;
        sh->lock = ptCfg->lock;
        sh->unlock = ptCfg->unlock;

        sh->buffer = ptCfg->buffer;
        sh->nBufferSize = ptCfg->nBufferSize;
        sh->nLength = 0;
        sh->nCursor = 0;

        sh->nControlCode = 0;
        sh->bIsOverlayInsert = false;
        sh->bIsLogin = false;

        sh->bInited = true;
    }
}

/*************************** End of file ****************************/
