#!/bin/bash
# Web访问日志分析脚本

if [ $# -ne 1 ]; then
    echo "用法：$0 <日志文件路径>"
    exit 1
fi

LOG=$1

if [ ! -f "$LOG" ]; then
    echo "错误：日志文件 '$LOG' 不存在！"
    exit 1
fi

echo "=============================="
echo "   Web访问日志分析报告"
echo "=============================="
echo "日志文件：$LOG"
echo "分析时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 1. 总请求数
total=$(wc -l < "$LOG")
echo "【1】总请求数：$total"
echo ""

# 2. Top 10 IP地址
echo "【2】访问量Top 10 IP："
awk '{print $1}' "$LOG" | sort | uniq -c | sort -rn | head -10
echo ""

# 3. 各状态码统计
echo "【3】HTTP状态码分布："
awk '{print $9}' "$LOG" | grep -E '^[0-9]+$' | sort | uniq -c | sort -rn
echo ""

# 4. 404错误URL Top 10
echo "【4】404错误页面Top 10："
awk '$9 == 404 {print $7}' "$LOG" | sort | uniq -c | sort -rn | head -10
echo ""

echo "分析完成！"
