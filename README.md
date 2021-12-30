## c_shell

![shell](https://iobucket.oss-cn-beijing.aliyuncs.com/images/shell.png)

`c shell` 是一个运行在单片机环境下的嵌入式 `shell`, 只有最简单的注册命令，执行命令功能

* 不支持 `tab` 键补全命令
* 上下键历史命令功能待添加

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
