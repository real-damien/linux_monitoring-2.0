#!/bin/bash

chmod +x check.sh
chmod +x remove_by_log.sh
chmod +x remove_by_creation_time.sh
chmod +x remove_by_mask.sh

. ./check.sh

case "$1" in
    1)
        echo "Cleaning by log file."
        # Удаление по log-файлу
        ./remove_by_log.sh
        ;;
    2)
        echo "Cleaning by creation date and time."
        # Удаление по дате и времени создания
        ./remove_by_creation_time.sh
        ;;
    3)
        echo "Cleaning by name mask (i.e. characters, underlining and date)."
        # Удаление по маске имени (т. е. символы, нижнее подчёркивание и дата). 
        ./remove_by_mask.sh
        ;;
esac