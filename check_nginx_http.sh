#!/bin/bash
# Keepalived 本机Nginx业务健康检测脚本
CHECK_URL="http://127.0.0.1:8088/check_status"
TIME_OUT=3

# 请求探测，获取HTTP状态码
CODE=$(curl -k -s -m ${TIME_OUT} -o /dev/null -w %{http_code} ${CHECK_URL})

# 2xx/3xx为正常，4xx/5xx/超时为故障
if [ $CODE -ge 200 ] && [ $CODE -lt 400 ];then
    exit 0
else
    exit 1
fi
