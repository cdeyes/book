#!/bin/bash
# ============================================
# 系统健康检查脚本
# 功能：监控系统资源，生成健康报告
# ============================================

# ---------- 全局配置 ----------
REPORT_DIR="/tmp/system_reports"
THRESHOLD_CPU=80      # CPU使用率告警阈值
THRESHOLD_MEM=80      # 内存使用率告警阈值
THRESHOLD_DISK=85     # 磁盘使用率告警阈值
ALERT_LOG="${REPORT_DIR}/alert.log"

# ---------- 函数定义 ----------

# 初始化环境
init() {
    mkdir -p "$REPORT_DIR"
    echo "" > "$ALERT_LOG"
    echo "检查时间：$(date '+%Y-%m-%d %H:%M:%S')" > "${REPORT_DIR}/health_report.txt"
    echo "==============================" >> "${REPORT_DIR}/health_report.txt"
}

# 记录告警信息
log_alert() {
    local level=$1    # WARN 或 CRITICAL
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$ALERT_LOG"
    echo "[$timestamp] [$level] $message" >> "${REPORT_DIR}/health_report.txt"
}

# 检查CPU使用率
check_cpu() {
    echo "正在检查CPU..." >> "${REPORT_DIR}/health_report.txt"
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
    echo "  CPU使用率：${cpu_usage}%" >> "${REPORT_DIR}/health_report.txt"

    if [ "$cpu_usage" -ge "$THRESHOLD_CPU" ]; then
        log_alert "WARN" "CPU使用率过高：${cpu_usage}%（阈值：${THRESHOLD_CPU}%）"
        echo "  CPU占用Top进程：" >> "${REPORT_DIR}/health_report.txt"
        ps aux --sort=-%cpu | head -4 >> "${REPORT_DIR}/health_report.txt"
    fi
}

# 检查内存使用率
check_memory() {
    echo "正在检查内存..." >> "${REPORT_DIR}/health_report.txt"
    local mem_info=$(free | awk '/^Mem:/{printf "%d %d", $3, $2}')
    local mem_used=$(echo $mem_info | awk '{print $1}')
    local mem_total=$(echo $mem_info | awk '{print $2}')
    local mem_percent=$((mem_used * 100 / mem_total))

    echo "  内存使用：${mem_used}MB / ${mem_total}MB (${mem_percent}%)" >> "${REPORT_DIR}/health_report.txt"

    if [ "$mem_percent" -ge "$THRESHOLD_MEM" ]; then
        log_alert "WARN" "内存使用率过高：${mem_percent}%（阈值：${THRESHOLD_MEM}%）"
    fi
}

# 检查磁盘使用率
check_disk() {
    echo "正在检查磁盘..." >> "${REPORT_DIR}/health_report.txt"
    local has_alert=0

    while read -r usage mount; do
        local usage_num=${usage%\%}
        echo "  ${mount}: ${usage}" >> "${REPORT_DIR}/health_report.txt"
        if [ "$usage_num" -ge "$THRESHOLD_DISK" ]; then
            log_alert "CRITICAL" "磁盘空间告警：${mount} 使用率${usage}"
            has_alert=1
        fi
    done < <(df -h | awk 'NR>1 && $1~/^\/dev/{print $5, $6}')

    if [ $has_alert -eq 0 ]; then
        echo "  所有磁盘分区使用率正常。" >> "${REPORT_DIR}/health_report.txt"
    fi
}

# 检查关键服务
check_services() {
    echo "正在检查关键服务..." >> "${REPORT_DIR}/health_report.txt"
    local services=("sshd" "crond" "network" "firewalld")

    for svc in "${services[@]}"; do
        if systemctl is-active --quiet "$svc" 2>/dev/null; then
            echo "  ${svc}: 运行中 ✓" >> "${REPORT_DIR}/health_report.txt"
        else
            log_alert "WARN" "服务 ${svc} 未运行！"
        fi
    done
}

# 生成摘要
generate_summary() {
    local alert_count=$(grep -c "WARN\|CRITICAL" "$ALERT_LOG" 2>/dev/null || echo 0)
    echo "" >> "${REPORT_DIR}/health_report.txt"
    echo "==============================" >> "${REPORT_DIR}/health_report.txt"
    echo "检查完成：$(date '+%Y-%m-%d %H:%M:%S')" >> "${REPORT_DIR}/health_report.txt"
    echo "告警总数：${alert_count}" >> "${REPORT_DIR}/health_report.txt"

    if [ "$alert_count" -eq 0 ]; then
        echo "系统状态：正常 ✓" >> "${REPORT_DIR}/health_report.txt"
    else
        echo "系统状态：存在告警 ✗" >> "${REPORT_DIR}/health_report.txt"
    fi
    echo "报告已保存至：${REPORT_DIR}/health_report.txt"
}

# ---------- 主流程 ----------
main() {
    init
    echo "开始系统健康检查..."
    check_cpu
    check_memory
    check_disk
    check_services
    generate_summary
    echo "检查完成！"
}

main "$@"
