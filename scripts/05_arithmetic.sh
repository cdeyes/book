#!/bin/bash
# 算术运算示例
a=10
b=3

# 方式1：使用(())（推荐）
echo "加法：$((a + b))"     # 13
echo "乘法：$((a * b))"     # 30
echo "幂运算：$((a ** 2))"  # 100

# 方式2：使用let
let "c = a + b"
echo "let结果：$c"           # 13

# 方式3：使用expr（注意空格和转义）
result=$(expr $a + $b)
echo "expr结果：$result"     # 13

# 自增自减
((a++))    # a变为11
echo "自增后：$a"
