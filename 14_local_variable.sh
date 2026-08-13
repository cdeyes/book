#!/bin/bash
name="全局变量"

my_func() {
    local name="局部变量"    # 仅在此函数内有效
    echo "函数内部：$name"   # 输出：局部变量
}

my_func
echo "函数外部：$name"       # 输出：全局变量
