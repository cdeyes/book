#!/bin/bash
# read命令示例

# 基本用法：读取一个变量
echo -n "请输入您的姓名："
read name
echo "您好，$name！"

# 读取多个变量（按空格分隔）
echo -n "请输入姓名和年龄："
read name age
echo "姓名：$name，年龄：$age"

# 设置读取超时时间
echo -n "请在5秒内输入："
if read -t 5 input; then
    echo "您输入了：$input"
else
    echo "输入超时！"
fi

# 隐藏输入内容（常用于密码输入）
echo -n "请输入密码："
read -s password
echo
echo "密码已接收（长度：${#password}）"
