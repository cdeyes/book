#!/bin/bash
# 文件信息检查脚本

if [ $# -ne 1 ]; then
    echo "用法：$0 <文件名>"
    exit 1
fi

FILE=$1

# 检查文件是否存在
if [ ! -e "$FILE" ]; then
    echo "错误：文件 '$FILE' 不存在！"
    exit 1
fi

# 检查是否为普通文件
if [ ! -f "$FILE" ]; then
    echo "错误：'$FILE' 不是普通文件！"
    exit 1
fi

# 检查是否可读
if [ ! -r "$FILE" ]; then
    echo "错误：文件 '$FILE' 不可读！"
    exit 1
fi

# 统计文件信息
lines=$(wc -l < "$FILE")
words=$(wc -w < "$FILE")
bytes=$(wc -c < "$FILE")

echo "文件：$FILE"
echo "  行数：$lines"
echo "  单词数：$words"
echo "  字节数：$bytes"
