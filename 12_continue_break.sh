#!/bin/bash
# continue和break示例
echo "=== 输出1-10中的奇数（跳过偶数）==="
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue    # 跳过偶数
    fi
    echo -n "$i "
done
echo ""

echo "=== 查找第一个大于50的数即停止 ==="
for i in 23 45 67 12 89 34; do
    if [ $i -gt 50 ]; then
        echo "找到第一个大于50的数：$i"
        break    # 找到后跳出循环
    fi
    echo "检查：$i（不大于50）"
done
