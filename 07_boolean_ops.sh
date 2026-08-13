#!/bin/bash
a=10
b=20

# 使用-a（与）
if [ $a -gt 5 -a $b -lt 30 ]; then
    echo "两个条件都满足"
fi

# 使用双中括号[[ ]]也可以使用&&和||
if [[ $a -gt 5 && $b -lt 30 ]]; then
    echo "两个条件都满足（[[ ]]语法）"
fi
