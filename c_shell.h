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
#ifndef C_SHELL_H
#define C_SHELL_H

/* Includes --------------------------------------------------------*/
#include "c_shell_cfg.h"
#include "stdint.h"
#include "stdbool.h"
#ifdef __cplusplus
extern "C" {
#endif

/* Global define ---------------------------------------------------*/
#define C_SHELL_VERSION     "1.0.0"

#if !defined(__GNUC__)
#define __GNUC__
#endif
/* Global macro ----------------------------------------------------*/
#if !defined(C_SHELL_SECTION)
    #if defined(__ARMCC_VERSION)
        #define C_SHELL_SECTION(__A)    __attribute__((section(__A)))
    #elif defined(__GNUC__)
        #define C_SHELL_SECTION(__A)    __attribute__((section(__A)))
    #else
        #define C_SHELL_SECTION(__A)
    #endif
#endif

#ifndef C_SHELL_USED
    #if defined(__ARMCC_VERSION)
        #define C_SHELL_USED          __attribute__((used))
    #elif defined(__GNUC__)
        #define C_SHELL_USED          __attribute__((used))
    #else
        #define C_SHELL_USED
    #endif
#endif

#if (C_SHELL_EXPORT_COMMAND_ENABLE == 1)
    #define C_SHELL_EXPORT_COMMAND(__FUNC, __NAME, __RESERVED, __DESC)  \
        static const char shell_command_name_##__NAME[] = #__NAME;      \
        static const char shell_command_desc_##__NAME[] = #__DESC;      \
        C_SHELL_USED const shell_command_t shell_command_obj_##__NAME   \
        C_SHELL_SECTION("section_command") = {                          \
            .tType = SHELL_COMMAND_FN_PTR_MAIN,                         \
            .name = shell_command_name_##__NAME,                        \
            .desc = shell_command_desc_##__NAME,                        \
            .pfnMain = __FUNC                                           \
        }
#else
    #define C_SHELL_EXPORT_COMMAND(__FUNC, __NAME, __ATTR, __DESC)
#endif

/* Global typedef --------------------------------------------------*/
typedef struct shell_obj shell_obj_t;
typedef struct shell_command shell_command_t;
struct shell_command {
    const char *name;
    const char *desc;
    union {
        void  (*pfn     );
        void  (*pfnMain )    (shell_obj_t *, int argc, char *argv[]);
        void  (*pfnCMain)    (               int argc, char *argv[]);
        void  (*pfnKey  )    (shell_obj_t *);
    };

    int32_t nKeyCode;

    enum {
        SHELL_COMMAND_FN_PTR_MAIN = 1,
        SHELL_COMMAND_FN_PTR_C_MAIN,
        SHELL_COMMAND_FN_PTR_KEY,
    } tType;

};

typedef struct shell_cfg shell_cfg_t;
struct shell_cfg {
    uint32_t    ( *read    )(char *buffer, uint32_t wSize);
    uint32_t    ( *write   )(const char *buffer, uint32_t wSize);
    bool        ( *login   )(const char *username, const char *password);
    void *      ( *lock    )(void *sh);
    void        ( *unlock  )(void *sh, void *pLockReturn);

    char                  *username;
    char                    *buffer;
    int32_t             nBufferSize;

#if (C_SHELL_EXPORT_COMMAND_ENABLE == 0)
    const shell_command_t   *ptBase;
    int32_t          nCommandNumber;
#endif
};

typedef struct shell_obj shell_obj_t;
struct shell_obj {
    uint32_t    ( *read    )(char *buffer, uint32_t wSize);
    uint32_t    ( *write   )(const char *buffer, uint32_t wSize);
    bool        ( *login   )(const char *username, const char *password);

    void *      ( *lock    )(void *sh);
    void        ( *unlock  )(void *sh, void *pLockReturn);

    char                   username[C_SHELL_MAXIMUM_USERNAME_SIZE];

    const shell_command_t   *ptBase;
    int32_t          nCommandNumber;

    int32_t            nControlCode;

    char                    *buffer;
    int32_t             nBufferSize;
    int32_t                 nLength;
    int32_t                 nCursor;

#if (C_SHELL_HISTORY_ENABLE == 1)
    struct {
        char                *buffer[C_SHELL_MAXIMUM_HISTORY_NUMER];
        int32_t              nTotal;
        int32_t             nCursor;
        int32_t               nTail;
    } tHistory;
#endif

    char                      *argv[C_SHELL_MAXIMUM_PARAM_NUMBER];
    char                       argc;

    bool           bIsOverlayInsert;
    bool                    bInited;
    bool                   bIsLogin;

};

/* Global variables ------------------------------------------------*/
/* Global function prototypes --------------------------------------*/
extern bool shell_init(shell_obj_t *sh, shell_cfg_t *ptCfg);
extern void shell_task(shell_obj_t *sh);
extern void shell_task_on_callback(shell_obj_t *sh, char c);
extern void shell_write(const shell_obj_t *sh, const char *buffer, int32_t nSize);

#ifdef __cplusplus
extern "C" {
#endif
#endif
/*************************** End of file ****************************/
