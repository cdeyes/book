#!/bin/bash
# 用户列表报告生成脚本

REPORT_FILE="user_report.txt"

echo "================================" > "$REPORT_FILE"
echo "       系统用户列表报告" >> "$REPORT_FILE"
echo "  生成时间：$(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
printf "%-15s %-8s %-25s %s\n" "用户名" "UID" "主目录" "登录Shell" >> "$REPORT_FILE"
echo "----------------------------------------------" >> "$REPORT_FILE"

# 提取用户信息并按UID排序
awk -F: '{printf "%-15s %-8s %-25s %s\n", $1, $3, $6, $7}' /etc/passwd | \
    sort -k2 -n >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
total=$(wc -l < /etc/passwd)
echo "用户总数：$total" >> "$REPORT_FILE"

cat "$REPORT_FILE"
