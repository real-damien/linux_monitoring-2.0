#!/bin/bash


# Файл лога, в который будут записываться данные
log_file="log_file.log"
> "$log_file"

start_time_to_display=`date +%T`
echo "Start time of the script: $start_time_to_display" >> "$log_file"
start_time=`date +%s`

chmod +x check.sh
chmod +x gen_files.sh
chmod +x timer.sh


. ./check.sh
. ./gen_files.sh
