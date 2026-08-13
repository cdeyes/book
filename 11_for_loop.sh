#!/bin/bash
# 示例1：遍历列表
echo "=== 遍历水果列表 ==="
for fruit in apple banana cherry durian; do
    echo "我喜欢 $fruit"
done

# 示例2：花括号展开（计算1到100的和）
echo ""
echo "=== 计算1到100的和 ==="
sum=0
for i in {1..100}; do
    ((sum += i))
done
echo "1+2+3+...+100 = $sum"

# 示例3：C语言风格for循环（打印三角形）
echo ""
echo "=== C语言风格循环 ==="
for ((i=1; i<=5; i++)); do
    for ((j=1; j<=i; j++)); do
        echo -n "* "
    done
    echo ""
done

# 示例4：遍历目录中的.conf文件
echo ""
echo "=== /etc目录下的.conf文件 ==="
for conf in /etc/*.conf; do
    echo "$(basename $conf) - $(wc -l < $conf) 行"
done
