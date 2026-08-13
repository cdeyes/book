#!/bin/bash
# 系统管理菜单脚本

while true; do
    clear
    echo "=============================="
    echo "       系统管理菜单"
    echo "=============================="
    echo "  1. 查看系统信息"
    echo "  2. 查看磁盘使用情况"
    echo "  3. 查看当前登录用户"
    echo "  4. 查看系统负载"
    echo "  0. 退出"
    echo "=============================="
    echo -n "请选择操作 [0-4]："
    read choice

    case $choice in
        1)
            echo "--- 系统信息 ---"
            uname -a
            ;;
        2)
            echo "--- 磁盘使用情况 ---"
            df -hT
            ;;
        3)
            echo "--- 当前登录用户 ---"
            who
            ;;
        4)
            echo "--- 系统负载 ---"
            uptime
            ;;
        0)
            echo "再见！"
            exit 0
            ;;
        *)
            echo "无效选择，请重新输入！"
            sleep 2
            ;;
    esac
    echo ""
    read -p "按回车键继续..."
done
