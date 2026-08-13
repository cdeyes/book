#!/bin/bash
# 成绩等级判定脚本

echo -n "请输入您的成绩（0-100）："
read score

# 输入验证
if ! [[ "$score" =~ ^[0-9]+$ ]] || [ "$score" -lt 0 ] || [ "$score" -gt 100 ]; then
    echo "输入无效！请输入0-100之间的整数。"
    exit 1
fi

# 等级判定
if [ "$score" -ge 90 ]; then
    grade="A（优秀）"
elif [ "$score" -ge 80 ]; then
    grade="B（良好）"
elif [ "$score" -ge 70 ]; then
    grade="C（中等）"
elif [ "$score" -ge 60 ]; then
    grade="D（及格）"
else
    grade="F（不及格）"
fi

echo "您的成绩等级为：$grade"
