#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
memory=$(top -bn1 | grep "MiB Mem")
mem_total=$(echo $mem_info | awk '{print $4}')
mem_used=$(echo $mem_info | awk '{print $8}')
mem_free=$(echo $mem_info | awk '{print $6}')
used_percent=$(awk "BEGIN {printf \"%.2f\", $mem_used / $mem_total * 100}")
free_percent=$(awk "BEGIN {printf \"%.2f\", $mem_free / $mem_total * 100}")
disk_total=$(df -h | grep "vda1" | awk '{print $2}' | tr -d 'G')
disk_used=$(df -h | grep "vda1" | awk '{print $3}' | tr -d 'G')
disk_free=$(df -h | grep "vda1" | awk '{print $4}' | tr -d 'G')
cpu_top_process=$(ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6)
mem_top_process=$(ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6)

echo "CPU Usage: $cpu_usage%"
echo "Total Memory Usage: "
echo "Free: $mem_free, Percentage : $free_percent% | Used: $mem_used, Percentage: $used_percent%"
echo "Total Disk Usage: "
echo "Free: $disk_free | Usage: $disk_used"
echo "Top 5 CPU Process:"
echo "$cpu_top_process"
echo "Top 5 Memory Process:"
echo "$mem_top_process"
