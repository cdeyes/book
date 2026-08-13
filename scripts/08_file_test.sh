#!/bin/bash
FILE="/etc/passwd"

if [ -e "$FILE" ]; then
    if [ -f "$FILE" ]; then
        echo "$FILE 是一个普通文件"
        if [ -r "$FILE" ]; then
            echo "  具有读取权限"
        fi
        echo "  文件大小：$(stat -c %s $FILE) 字节"
    elif [ -d "$FILE" ]; then
        echo "$FILE 是一个目录"
    fi
else
    echo "$FILE 不存在"
fi
