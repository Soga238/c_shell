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

#if (C_SHELL_EXPORT_COMMAND_ENABLE == 1)
    #if defined(__CC_ARM) || (defined(__ARMCC_VERSION) && __ARMCC_VERSION >= 6000000)
        extern const unsigned int section_command$$Base;
        extern const unsigned int section_command$$Limit;
    #elif defined(__GNUC__)
        extern const unsigned int _ld_command_start;
        extern const unsigned int _ld_command_end;
    #endif
#endif

/* Private variables -----------------------------------------------*/
#if (C_SHELL_SHOW_INFORMATION == 1)
static const char *c_information =
    "\r\n"
    "  _____    _____ _    _ ______ _      _\r\n"
    " / ____|  / ____| |  | |  ____| |    | |\r\n"
    "| |      | (___ | |__| | |__  | |    | |\r\n"
    "| |       \\___ \\|  __  |  __| | |    | |\r\n"
    "| |____   ____) | |  | | |____| |____| |____\r\n"
    " \\_____| |_____/|_|  |_|______|______|______|\r\n"
    "\r\n"
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

static void on_command_list_all(shell_obj_t *sh, int argc, char *argv[]);
static void on_command_clear(shell_obj_t *sh, int argc, char *argv[]);

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
    write_bytes(sh, "\n\r", 2);
    write_string(sh, sh->username);
    write_bytes(sh, ":/ ", 3);
}

static void write_fixed_number_char(shell_obj_t *sh, const char (*string)[10], uint32_t wSize)
{
    volatile uint32_t i;
    const char *buf = (char *)string;

    /*! 减少传送次数 */
    i = wSize / 10;
    while (i-- > 0) {
        write_bytes(sh, buf, 10);
    }

    i = wSize % 10;
    write_bytes(sh, buf, i);
}

static void cursor_backspace(shell_obj_t *sh, int32_t nLength)
{
    const char buf[10] = "\b\b\b\b\b\b\b\b\b\b";
    if (nLength > 0) {
        write_fixed_number_char(sh, &buf, nLength);
    }
}

static void parse_argv(shell_obj_t *sh)
{
    char *token;
    void *pReturn = NULL;

    /*! strtok is not thread safety*/

    if (NULL != sh->lock) {
        pReturn = sh->lock(sh);
    }

    sh->argc = 0;
    token = strtok(sh->buffer, " ");

    do {
        sh->argv[sh->argc++] = token;
        token = strtok(NULL, " ");
    } while (token && (sh->argc < COUNT_OF(sh->argv)));

    if (NULL != sh->unlock) {
        sh->unlock(sh, pReturn);
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
        if (ptCmd->tType == SHELL_COMMAND_FN_PTR_MAIN ||
            ptCmd->tType == SHELL_COMMAND_FN_PTR_C_MAIN) {
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
        if (ptCmd->tType == SHELL_COMMAND_FN_PTR_MAIN) {
            ptCmd->pfnMain(sh, sh->argc, sh->argv);
        } else {
            ptCmd->pfnCMain(sh->argc, sh->argv);
        }
        bFound = true;
    }

    sh->nCursor = sh->nLength = 0;

    if (!bFound) {
        write_string(sh, error_text(SHELL_COMMAND_NOT_FOUND));
    }
}

static bool execute_key_command(shell_obj_t *sh, int32_t nKeyCode)
{
    const char tb[4] = {0, 8, 16, 24};
    const shell_command_t *ptCmd;
    int32_t i, nMask;

    /*! 遍历执行按键函数 */
    for (i = 0; i < COUNT_OF(s_tCommands); ++i) {
        ptCmd = &s_tCommands[i];
        if (ptCmd->tType != SHELL_COMMAND_FN_PTR_KEY) {
            continue;
        }

        for (char j = 0; j < 4; ++j) {
            nMask = (int32_t)(0xFFFFFFFF >> tb[j]) & nKeyCode;
            if (ptCmd->nKeyCode == nMask && ptCmd->pfnKey) {
                ptCmd->pfnKey(sh);
                return true;
            }
        }
    }

    return false;
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
        // sh->buffer[sh->nLength] = 0;

        i = sh->nLength - sh->nCursor;
        write_bytes(sh, sh->buffer + sh->nCursor - 1, i + 1);

        cursor_backspace(sh, sh->nLength - sh->nCursor);
    }
}

#if (C_SHELL_HISTORY_ENABLE == 1)
static void add_history(shell_obj_t *sh)
{
    char *buf;

    if (sh->nLength == 0) {
        return;
    }

    buf = sh->tHistory.buffer[sh->tHistory.nTail];
    memcpy(buf, sh->buffer, sh->nLength);
    *(buf + sh->nLength) = 0;

    sh->tHistory.nTail = (sh->tHistory.nTail + 1) % C_SHELL_MAXIMUM_HISTORY_NUMER;
    if (sh->tHistory.nTotal < C_SHELL_MAXIMUM_HISTORY_NUMER) {
        sh->tHistory.nTotal += 1;
    }
}

static const char *get_history(shell_obj_t *sh, bool bIsUp)
{
    char *buf = NULL;

    if (sh->tHistory.nTotal <= 0) {
        return buf;
    } else if (sh->tHistory.nCursor == -1) {
        sh->tHistory.nCursor = sh->tHistory.nTail;
    }

    sh->tHistory.nCursor = bIsUp ?
                           (sh->tHistory.nCursor - 1 + sh->tHistory.nTotal) % sh->tHistory.nTotal :
                           (sh->tHistory.nCursor + 1) % sh->tHistory.nTotal;

    buf = sh->tHistory.buffer[sh->tHistory.nCursor];

    return buf;
}

static void clear_command_line(shell_obj_t *sh)
{
    const char buf[10] = "          ";

    cursor_backspace(sh, sh->nCursor);
    write_fixed_number_char(sh, &buf, sh->nLength);
    cursor_backspace(sh, sh->nLength);
}

#endif

static void on_key_up_arrow(shell_obj_t *sh)
{
#if (C_SHELL_HISTORY_ENABLE == 1)
    const char *p = get_history(sh, true);

    if (NULL != p) {
        clear_command_line(sh);
        sh->nCursor = sh->nLength = 0;

        for (size_t i = 0, j = strlen(p); i < j; ++i) {
            normal_key_code_insert(sh, *(p + i));
        }
    }
#else
    UNUSED_PARAM(sh);
#endif
}

static void on_key_down_arrow(shell_obj_t *sh)
{
#if (C_SHELL_HISTORY_ENABLE == 1)
    const char *p = get_history(sh, false);

    if (NULL != p) {
        clear_command_line(sh);
        sh->nCursor = sh->nLength = 0;

        for (size_t i = 0, j = strlen(p); i < j; ++i) {
            normal_key_code_insert(sh, *(p + i));
        }
    }
#else
    UNUSED_PARAM(sh);
#endif
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
        cursor_backspace(sh, 1);
    }
}

static bool login_required(shell_obj_t *sh)
{
    if (!sh->bIsLogin) {
        sh->bIsLogin = (NULL != sh->login) ? sh->login(sh->username, sh->buffer) : true;
        sh->nCursor = sh->nLength = 0;
        if (sh->bIsLogin) {
#if (C_SHELL_SHOW_INFORMATION == 1)
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
#if (C_SHELL_HISTORY_ENABLE == 1)
    add_history(sh);
#endif

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
    if (sh->nCursor > 0) {
        write_bytes(sh, "\b", 1);
        write_bytes(sh, sh->buffer + sh->nCursor, sh->nLength - sh->nCursor);
        write_bytes(sh, " ", 1);

        cursor_backspace(sh, sh->nLength - sh->nCursor + 1);

        sh->nCursor -= 1;
        sh->nLength -= 1;

        for (int32_t i = sh->nCursor; i < sh->nLength; ++i) {
            sh->buffer[i] = sh->buffer[i + 1];
        }

        sh->buffer[sh->nLength] = 0;
    }
}

static inline void print_command(shell_obj_t *sh, const shell_command_t *ptCmd)
{
    write_bytes(sh, "\t+ ", 3);
    write_string(sh, ptCmd->name ? ptCmd->name : "");
    write_bytes(sh, ":\t", 2);
    write_string(sh, ptCmd->desc ? ptCmd->desc : "");
    write_bytes(sh, "\r\n", 2);
}

static void on_command_list_all(shell_obj_t *sh, int argc, char *argv[])
{
    UNUSED_PARAM(argc);
    UNUSED_PARAM(argv);

    const shell_command_t *ptCmd;

    write_bytes(sh, "\r\ncommands:\r\n", 13);
    for (int32_t i = 0; i < COUNT_OF(s_tCommands); ++i) {
        ptCmd = s_tCommands + i;
        if (ptCmd->tType != SHELL_COMMAND_FN_PTR_KEY) {
            print_command(sh, ptCmd);
        }
    }

    for (int32_t i = 0; i < sh->nCommandNumber && NULL != sh->ptBase; ++i) {
        ptCmd = sh->ptBase + i;
        if (ptCmd->tType != SHELL_COMMAND_FN_PTR_KEY) {
            print_command(sh, ptCmd);
        }
    }
}

static void on_command_clear(shell_obj_t *sh, int argc, char *argv[])
{
    UNUSED_PARAM(argc);
    UNUSED_PARAM(argv);

    write_string(sh, "\033[2J\033[1H");
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
        wCount = NULL != sh->read ? sh->read(buffer, sizeof(buffer)) : 0;
        for (i = 0; i < wCount && i < sizeof(buffer); ++i) {
            shell_handler(sh, buffer[i]);
        }
    }
}

void shell_task_on_callback(shell_obj_t *sh, char c)
{
    if (NULL != sh && sh->bInited) {
        shell_handler(sh, c);
    }
}

void shell_write(const shell_obj_t *sh, const char *buffer, int32_t nSize)
{
    if (NULL != sh && NULL != sh->write) {
        sh->write(buffer, nSize);
    }
}

bool shell_init(shell_obj_t *sh, shell_cfg_t *ptCfg)
{
    if (NULL != sh) {
        sh->bInited = false;

        if (NULL == ptCfg || NULL == ptCfg->write ||
            NULL == ptCfg->buffer) {
            return false;
        }

        if (NULL != ptCfg->username) {
            snprintf(sh->username, sizeof(sh->username), "%s", ptCfg->username);
        }

#if (C_SHELL_EXPORT_COMMAND_ENABLE == 0)
        sh->ptBase = ptCfg->ptBase;
        sh->nCommandNumber = ptCfg->nCommandNumber;
#else
    #if defined(__CC_ARM) || (defined(__ARMCC_VERSION) && __ARMCC_VERSION >= 6000000)
        sh->ptBase = (shell_command_t *)(&section_command$$Base);
        sh->nCommandNumber = ((unsigned)(&section_command$$Limit) - (unsigned)(&section_command$$Base)) / sizeof(shell_command_t);
    #elif defined(__GNUC__)
        sh->ptBase = (shell_command_t *)(&_ld_command_start);
        sh->nCommandNumber = ((unsigned)(&_ld_command_end) - (unsigned)(&_ld_command_start)) / sizeof(shell_command_t);
    #else
        #error "nonsupport compiler"
    #endif
#endif

        sh->write = ptCfg->write;
        sh->read = ptCfg->read;
        sh->login = ptCfg->login;
        sh->lock = ptCfg->lock;
        sh->unlock = ptCfg->unlock;

        sh->buffer = ptCfg->buffer;
#if (C_SHELL_HISTORY_ENABLE == 1)
        sh->tHistory.nTotal = 0;
        sh->tHistory.nTail = 0;
        sh->tHistory.nCursor = -1; /*! invalid value */
        sh->nBufferSize =
            ptCfg->nBufferSize / (1 + C_SHELL_MAXIMUM_HISTORY_NUMER);
        for (int32_t i = 0; i < C_SHELL_MAXIMUM_HISTORY_NUMER; ++i) {
            sh->tHistory.buffer[i] = sh->buffer + (i + 1) * sh->nBufferSize;
        }
#else
        sh->nBufferSize = ptCfg->nBufferSize;
#endif

        if (0 == ptCfg->nBufferSize) {
            return false;
        }

        sh->nLength = 0;
        sh->nCursor = 0;

        sh->nControlCode = 0;
        sh->bIsOverlayInsert = false;
        sh->bIsLogin = false;
        sh->bInited = true;
        
        return true;
    }
    
    return false;
}

/*************************** End of file ****************************/
