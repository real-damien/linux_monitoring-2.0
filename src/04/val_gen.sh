#!/bin/bash

# Функция для генерации случайного IP-адреса
generate_ip() {
    echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

# Функция для генерации случайного кода ответа
generate_status_code() {
    local codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
    local code=${codes[$RANDOM % ${#codes[@]}]}
    echo "$code"
}

# Описание кодов ответа:
# 200: Успешно
# 201: Создано
# 400: Плохой запрос
# 401: Не авторизован
# 403: Доступ запрещён
# 404: Не найдено
# 500: Внутренняя ошибка сервера
# 501: Не реализовано
# 502: Плохой шлюз
# 503: Сервис недоступен

# Функция для генерации случайного метода
generate_method() {
    local methods=("GET" "POST" "PUT" "PATCH" "DELETE")
    local method=${methods[$RANDOM % ${#methods[@]}]}
    echo "$method"
}

# Функция для генерации случайного URL
generate_url() {
    local urls=("/index.html" "/about.html" "/contact" "/products" "/services")
    local url=${urls[$RANDOM % ${#urls[@]}]}
    echo "$url"
}

# Функция для генерации случайного User-Agent
generate_user_agent() {
    local agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
    local agent=${agents[$RANDOM % ${#agents[@]}]}
    echo "$agent"
}

# Функция для генерации случайной даты в пределах года 2025 в формате Nginx combined log
generate_date() {
    local year="2025"
    local month_num=$((RANDOM % 12 + 1))
    local day=$((RANDOM % 28 + 1))

    local months=("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")

    local month_name="${months[month_num - 1]}"

    printf "%02d/%s/%d" "$day" "$month_name" "$year"
}