#!/bin/bash

# 获取脚本所在的目录路径
script_dir=$(dirname "$0")

# 初始化日期
current_date=$(date "+%Y-%m-%d")
log_file="$script_dir/network_traffic_$current_date.log"

while true; do
    # 获取当前的日期
    new_date=$(date "+%Y-%m-%d")

    # 如果日期已经发生变化，创建一个新的日志文件
    if [ "$new_date" != "$current_date" ]; then
        current_date="$new_date"
        log_file="$script_dir/network_traffic_$current_date.log"
    fi

    # 获取当前的日期和时间
    current_time=$(date "+%Y-%m-%d %H:%M:%S")

    # 使用 iftop 监控网络流量并将结果追加到日志文件
    iftop -t -s 2 -n -N | awk -v date="$current_time" '{print date, $0}' >> "$log_file"

    # 使用 nload 监控网络流量并将结果追加到日志文件
    # nload -t 2 -o -o -u K | awk -v date="$current_time" '{print date, $0}' >> "$log_file"

    # 如果使用 nload，请取消注释上面的行并注释掉 iftop 相关行

    # 等待5分钟
    sleep 300
done