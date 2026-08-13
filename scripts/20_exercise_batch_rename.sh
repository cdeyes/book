#!/bin/bash
# 批量文件重命名脚本

if [ $# -ne 1 ]; then
    echo "用法：$0 <目录路径>"
    exit 1
fi

DIR=$1

# 安全检查
if [ ! -d "$DIR" ]; then
    echo "错误：目录 '$DIR' 不存在！"
    exit 1
fi

# 检查是否包含.txt文件
shopt -s nullglob
txt_files=("$DIR"/*.txt)
shopt -u nullglob

if [ ${#txt_files[@]} -eq 0 ]; then
    echo "目录 '$DIR' 中没有.txt文件。"
    exit 0
fi

echo "找到 ${#txt_files[@]} 个.txt文件，开始重命名..."

count=0
for txt in "${txt_files[@]}"; do
    doc="${txt%.txt}.doc"
    if mv "$txt" "$doc"; then
        echo "  $(basename "$txt") -> $(basename "$doc")"
        ((count++))
    else
        echo "  重命名失败：$(basename "$txt")"
    fi
done

echo "完成！共重命名 $count 个文件。"
