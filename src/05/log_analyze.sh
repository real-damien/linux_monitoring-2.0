LOG_FILE="../04/nginx_log_day_1.log"

case $1 in
    1)
        echo "1. All entries sorted by response code:"
        awk '{print $0}' "$LOG_FILE" | sort -k10,10n
        ;;
    2)
        echo "2. All unique IPs:"
        awk '{print $1}' "$LOG_FILE" | sort | uniq
        ;;
    3)
        echo "3. All error requests (4xx or 5xx):"
        awk '$10 ~ /^[45]/ {print $0}' "$LOG_FILE"
        ;;
    4)
        echo "4. All unique IPs with error requests:"
        awk '$10 ~ /^[45]/ {print $1}' "$LOG_FILE" | sort | uniq
        ;;
esac