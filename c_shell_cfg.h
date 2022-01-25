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
#ifndef C_SHELL_CFG_H
#define C_SHELL_CFG_H

/* Includes --------------------------------------------------------*/
#ifdef __cplusplus
extern "C" {
#endif

/* Global define ---------------------------------------------------*/
#define SHELL_SHOW_INFORMATION          1
#define SHELL_MAXIMUM_USERNAME_SIZE     16

/*! 包含命令名在内，命令行最大参数个数，不能小于 1 */
#define SHELL_MAXIMUM_PARAM_NUMBER      3
#if (SHELL_MAXIMUM_PARAM_NUMBER <= 0)
#error "SHELL_MAXIMUM_PARAM_NUMBER < 0"
#endif

/*! 历史记录条数，建议不超过 5 */
#define SHELL_MAXIMUM_HISTORY_NUMER     3
#if (SHELL_MAXIMUM_HISTORY_NUMER > 0)
    #define SHELL_HISTORY_ENABLED
#endif

/* Global macro ----------------------------------------------------*/
/* Global typedef --------------------------------------------------*/
/* Global variables ------------------------------------------------*/
/* Global function prototypes --------------------------------------*/

#ifdef __cplusplus
extern "C" {
#endif
#endif
/*************************** End of file ****************************/
