#!/bin/bash
# Web访问日志分析脚本

LOG_FILE="/var/log/nginx/access.log"

echo "=============================="
echo "   Web访问日志分析报告"
echo "=============================="

# 1. 访问量统计
echo ""
echo "【1. 总访问量】"
total=$(wc -l < "$LOG_FILE")
echo "总请求数：$total"

# 2. 各状态码统计
echo ""
echo "【2. HTTP状态码分布】"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

# 3. 访问量最大的IP
echo ""
echo "【3. 访问量Top 10 IP】"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10

# 4. 404错误页面
echo ""
echo "【4. 404错误页面Top 10】"
awk '$9 == 404 {print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
