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
#include "stdint.h"
#ifdef __cplusplus
extern "C" {
#endif

/* Global define ---------------------------------------------------*/
/* Global macro ----------------------------------------------------*/
/* Global typedef --------------------------------------------------*/
typedef struct shell_command shell_command_t;
struct shell_command {
    const char *name;
    const char *desc;
    union {
        void  (*pfn     );
        void  (*pfnMain )    (char argc, char *argv);
        void  (*pfnKey  )    (void *);
    };

    int32_t nKeyValue;

    enum {
        SHELL_COMMAND_FN_PTR_MAIN = 0,
        SHELL_COMMAND_FN_PTR_KEY,
    } tType;

};

typedef struct shell_obj shell_obj_t;
struct shell_obj {
    const shell_command_t   *ptBase;
    int32_t          nCommandNumber;

    char                    *buffer;
    int32_t             nBufferSize;

    char                  *username;
    char                  *password;
};

/* Global variables ------------------------------------------------*/
/* Global function prototypes --------------------------------------*/
extern void shell_init(shell_obj_t *sh, char *buffer, int32_t nBufferSize);
void shell_handler(shell_obj_t *sh, char data);

#ifdef __cplusplus
extern "C" {
#endif
#endif
/*************************** End of file ****************************/
