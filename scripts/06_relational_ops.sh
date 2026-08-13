#!/bin/bash
a=10
b=20

if [ $a -eq $b ]; then
    echo "a等于b"
elif [ $a -gt $b ]; then
    echo "a大于b"
else
    echo "a小于b"    # 输出这行
fi
