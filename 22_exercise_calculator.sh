#!/bin/bash
# 简单计算器脚本

calculate() {
    local a=$1
    local op=$2
    local b=$3
    local result

    case $op in
        "+") result=$((a + b)) ;;
        "-") result=$((a - b)) ;;
        "*") result=$((a * b)) ;;
        "/")
            if [ "$b" -eq 0 ]; then
                echo "错误：除数不能为零！" >&2
                return 1
            fi
            result=$((a / b))
            ;;
        *)
            echo "错误：不支持的运算符 '$op'" >&2
            return 1
            ;;
    esac

    echo "$a $op $b = $result"
    return 0
}

# 参数检查
if [ $# -ne 3 ]; then
    echo "用法：$0 <操作数1> <运算符> <操作数2>"
    echo "示例：$0 15 + 7"
    exit 1
fi

# 验证操作数是否为整数
if ! [[ "$1" =~ ^-?[0-9]+$ ]] || ! [[ "$3" =~ ^-?[0-9]+$ ]]; then
    echo "错误：操作数必须为整数！"
    exit 1
fi

calculate "$1" "$2" "$3"
