#!/bin/bash
# 演示$*与$@的区别

# 使用$*时，所有参数被视为一个整体
echo "使用$*: "
for arg in "$*"; do
    echo "  $arg"    # 输出：a b c（一行）
done

# 使用$@时，每个参数保持独立
echo "使用$@: "
for arg in "$@"; do
    echo "  $arg"    # 输出：a、b、c（三行）
done
