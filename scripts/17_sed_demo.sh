#!/bin/bash
# sed综合示例

echo "=== 原始文件 ==="
cat -n /etc/passwd | head -5

# 示例1：打印指定行
echo ""
echo "=== 打印第3行 ==="
sed -n '3p' /etc/passwd

# 示例2：删除行
echo ""
echo "=== 删除第1-2行 ==="
sed '1,2d' /etc/passwd | head -3

# 示例3：替换文本
echo ""
echo "=== 将/bin/bash替换为/usr/bin/bash ==="
sed 's|/bin/bash|/usr/bin/bash|' /etc/passwd | head -3

# 示例4：使用正则表达式
echo ""
echo "=== 删除所有空行 ==="
sed '/^$/d' /etc/passwd
