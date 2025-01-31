#!/bin/bash

check_disk_space() {
    # Получаем доступное место на корневом разделе в килобайтах
    available_space=$(df -k / | tail -1 | awk '{print $4}')

    # Проверяем, меньше ли доступное пространство 1 ГБ (1048576 килобайт)
    if (( available_space < 1048576 )); then
        echo "Error: Not enough disk space (<1GB left)."
        exit 1
    fi
}

# Вызов функции
check_disk_space

# Текущая дата в формате DDMMYY
current_date="$(date +%d%m%y)"
log_date="$(date +%d.%m.%y)"

# Файл лога, в который будут записываться данные
log_file="log_file.log"
> "$log_file"

# Получение параметров
absolute_path="$1"
num_subfolders="$2"
folder_name_letters="$3"
num_files_per_folder="$4"
file_name_letters="${5%.*}"
file_ext_letters="${5#*.}"
file_size_kb="${6%kb}"

while [[ ${#folder_name_letters} -lt 4 ]]; do
  folder_name_letters=$folder_name_letters${folder_name_letters: -1}
done

while [[ ${#file_name_letters} -lt 4 ]]; do
  file_name_letters=$file_name_letters${file_name_letters: -1}
done

default_file_name_letters=$file_name_letters

for (( i = 0; i < $num_subfolders; i++)); do
  check_disk_space
  mkdir -p ${absolute_path}${folder_name_letters}_${current_date}
  echo "Created folder: ${absolute_path}${folder_name_letters}_${current_date}" >> $log_file
  for (( j = 0; j < $num_files_per_folder; j++)); do
    check_disk_space
    # dd - Команда для низкоуровневого копирования и преобразования данных. Заполняем нулями файл. 2>/dev/null - подавление ошибок.
    dd if=/dev/zero of="${absolute_path}${folder_name_letters}_${current_date}/${file_name_letters}_${current_date}.${file_ext_letters}" bs=1K count="$file_size_kb" 2>/dev/null
    echo "Created file: ${absolute_path}${folder_name_letters}_${current_date}/${file_name_letters}_${current_date}.${file_ext_letters} ${log_date} ${file_size_kb}kb">>$log_file
    file_name_letters=$file_name_letters${file_name_letters: -1}
  done
  file_name_letters=$default_file_name_letters
  folder_name_letters=$folder_name_letters${folder_name_letters: -1}
done

echo "Directory and file structure created successfully. Log file: $log_file"