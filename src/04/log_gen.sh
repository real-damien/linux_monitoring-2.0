#!/bin/bash

# Генерация 5 лог-файлов
for file_num in {1..5}; do
    date=$(generate_date)
    log_file="nginx_log_day_$file_num.log"
    echo "Generating $log_file for date $date..."

    # Генерируем случайное количество записей
    num_records=$((RANDOM % 901 + 100))

    # Инициализация времени
    start_hour=2
    start_minute=11
    start_second=15

    for i in $(seq 1 $num_records); do
        ip=$(generate_ip)

        # Увеличиваем время для каждой записи
        start_second=$((start_second + 9))
        if ((start_second >= 60)); then
            start_second=0
            ((start_minute++))
            if ((start_minute >= 60)); then
                start_minute=0
                ((start_hour++))
                if ((start_hour >= 24)); then
                    start_hour=0
                fi
            fi
        fi

        time=$(printf "%02d:%02d:%02d" $start_hour $start_minute $start_second)

        method=$(generate_method)
        url=$(generate_url)
        protocol="HTTP/1.1"
        status_code=$(generate_status_code)
        size=$((RANDOM % 5000 + 100))
        referrer="http://21-school.ru"
        user_agent=$(generate_user_agent)

        echo "$ip - - [$date:$time +0000] \"$method $url $protocol\" $status_code $size \"$referrer\" \"$user_agent\"" >> $log_file
    done
done

echo "Log files generated successfully."