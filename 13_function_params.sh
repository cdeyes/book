#!/bin/bash
# 函数参数与返回值示例

# 示例1：使用return返回状态码
check_user() {
    local username=$1
    if id "$username" > /dev/null 2>&1; then
        return 0    # 用户存在
    else
        return 1    # 用户不存在
    fi
}

check_user "root"
if [ $? -eq 0 ]; then
    echo "root用户存在"
fi

# 示例2：使用echo返回计算结果
calculate() {
    local a=$1
    local op=$2
    local b=$3
    case $op in
        "+") echo $((a + b)) ;;
        "-") echo $((a - b)) ;;
        "*") echo $((a * b)) ;;
        "/") echo $((a / b)) ;;
        *) echo "未知运算符" ;;
    esac
}

result=$(calculate 15 "+" 7)
echo "15 + 7 = $result"
result=$(calculate 20 "*" 3)
echo "20 x 3 = $result"
