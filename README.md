## c_shell

![shell](https://iobucket.oss-cn-beijing.aliyuncs.com/images/shell.png)

`c shell` 是一个运行在单片机环境下的嵌入式 `shell`, 只有最简单的注册命令，执行命令功能

* 支持 `Left + Right + Up + Down + BackSpace + Insert + Enter`键盘按键

## 两种命令导出方式

* 静态命令表

将结构体 `shell_cfg_t` 中的 `ptBase` 和`nCommandNumber` 指向用户自己定义的命令表, 调用 `shell_init` 进行初始化。

* 命令宏定义
 
使用 `GCC` 编译时，需要在ld文件中的只读数据区添加:

```c
    . = ALIGN(4);
    _ld_command_start = ABSOLUTE(.);
    KEEP(*(section_command))
    _ld_command_end = ABSOLUTE(.);
```

目的是把散落在各个文件的函数，都存储在链接文件中的 `section_command` 段内

## 使用方法

```C
#include "string.h"
#include "c_shell.h"

void test(shell_obj_t *sh, char argc, char *argv[]);

const shell_command_t g_tShellCommands[1] = {
    {
        .tType = SHELL_COMMAND_FN_PTR_MAIN,
        .name = "test",
        .desc = "test",
        .pfn = test,
    },
};

void test(shell_obj_t *sh, char argc, char *argv[])
{
    shell_write(sh, "This is test", sizeof("This is test"));
    for (int i = 1; i < argc; ++i) {
        shell_write(sh, argv[i], (int32_t)strlen(argv[i]));
    }
}

#if (0)
void test_func2(shell_obj_t *sh, int argc, char *argv[])
{
    shell_write(sh, "\r\nfunc test2", sizeof("\r\nfunc test2"));
}

C_SHELL_EXPORT_COMMAND(test_func2, test_func2, 0, test_func2);
#endif

uint32_t read(char *buffer, uint32_t wSize)
{
    return 0;
}

uint32_t write(const char *buffer, uint32_t wSize)
{
    return 0;
}

bool check_password(const char *username, const char *password)
{
    return 0 == strcmp(password, "123456");
}

int main()
{
    char buffer[64];

    shell_obj_t shell;
    shell_cfg_t tCfg = {
        .read               = read,
        .write              = write,

        .nBufferSize        = sizeof(buffer),
        .buffer             = buffer,

        .username           = "admin",
        .login              = check_password,

        .ptBase             = g_tShellCommands,
        .nCommandNumber     = 1,

        .lock               = NULL,
        .unlock             = NULL,
    };

    shell_init(&shell, &tCfg);

    while (1) {
        shell_task(&shell);
    }

    return 0;
}

```
