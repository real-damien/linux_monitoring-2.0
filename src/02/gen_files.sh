#!/bin/bash

check_disk_space() {
    # Получаем доступное место на корневом разделе в килобайтах
    available_space=$(df -k / | tail -1 | awk '{print $4}')

    # Проверяем, меньше ли доступное пространство 1 ГБ (1048576 килобайт)
    if (( available_space < 1048576 )); then
        echo "Error: Not enough disk space (<1GB left)."
        . ./timer.sh
        exit 1
    fi
}

# Вызов функции
check_disk_space

# Текущая дата в формате DDMMYY
current_date=$"$(date +%d%m%y)"
log_date="$(date +%d.%m.%y)"


# Получение параметров
absolute_path="$(pwd)/"
num_subfolders="100"
folder_name_letters="$1"
file_name_letters="${2%.*}"
file_ext_letters="${2#*.}"
file_size_mb="${3%Mb}"

while [[ ${#folder_name_letters} -lt 4 ]]; do
  folder_name_letters=$folder_name_letters${folder_name_letters: -1}
done

while [[ ${#file_name_letters} -lt 4 ]]; do
  file_name_letters=$file_name_letters${file_name_letters: -1}
done

default_file_name_letters=$file_name_letters

for (( i = 0; i < $num_subfolders; i++)); do
  check_disk_space
  num_files_per_folder=$((1 + RANDOM % 10000))
  mkdir -p ${folder_name_letters}_${current_date}
  echo "Created folder: ${absolute_path}${folder_name_letters}_${current_date}" >> $log_file
  for (( j = 0; j < $num_files_per_folder; j++)); do
    check_disk_space
    # dd - Команда для низкоуровневого копирования и преобразования данных. Заполняем нулями файл. 2>/dev/null - подавление ошибок.
    dd if=/dev/zero of="${folder_name_letters}_${current_date}/${file_name_letters}_${current_date}.${file_ext_letters}" bs=1M count="$file_size_mb" 2>/dev/null
    echo "Created file: ${absolute_path}${folder_name_letters}_${current_date}/${file_name_letters}_${current_date}.${file_ext_letters} ${log_date} ${file_size_mb}Mb">>$log_file
    file_name_letters=$file_name_letters${file_name_letters: -1}
  done
  file_name_letters=$default_file_name_letters
  folder_name_letters=$folder_name_letters${folder_name_letters: -1}
done

echo "Directory and file structure created successfully. Log file: $log_file"
