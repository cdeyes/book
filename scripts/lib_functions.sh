# === 函数库文件：lib_functions.sh ===
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') $1"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') $1" >&2
}

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "错误：请使用root权限运行此脚本！"
        exit 1
    fi
}
