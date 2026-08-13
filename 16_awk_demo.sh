#!/bin/bash
# awk综合示例

# 示例1：打印/etc/passwd中的用户名和UID
echo "=== 系统用户列表 ==="
awk -F: '{ printf "%-15s UID=%s\n", $1, $3 }' /etc/passwd | head -10

# 示例2：条件过滤（打印UID>=1000的普通用户）
echo ""
echo "=== 普通用户（UID>=1000）==="
awk -F: '$3 >= 1000 { print $1, $3, $7 }' /etc/passwd

# 示例3：使用BEGIN和END块
echo ""
echo "=== 磁盘使用统计 ==="
df -h | awk '
BEGIN { print "文件系统\t大小\t已用\t可用\t使用率" }
NR > 1 { print $1"\t"$2"\t"$3"\t"$4"\t"$5 }
END { print "--- 共 "NR-1" 个文件系统 ---" }
'

# 示例4：统计和计算
echo ""
echo "=== 文件大小统计 ==="
ls -l /etc/*.conf 2>/dev/null | awk '
BEGIN { total = 0; count = 0 }
{
    total += $5
    count++
}
END {
    printf "共 %d 个配置文件\n", count
    printf "总大小: %d 字节\n", total
    printf "平均大小: %.0f 字节\n", total/count
}'
