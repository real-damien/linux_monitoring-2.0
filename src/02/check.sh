#!/bin/bash

# Проверяем, что в пути файла не содержатся папки bin и sbin
if [[ $(pwd) == *"/sbin"* || $(pwd) == *"/bin"* ]]; then
    echo "Error: The path or filename must not contain 'bin' or 'sbin'."
    exit 1
fi

# Проверяем, что передано ровно 3 параметра
if [ "$#" -ne 3 ]; then
    echo "Error: Exactly 3 arguments are required."
    exit 1
fi

# Проверка, что первый параметр содержит не более 7 знаков
if [[ "${#1}" -gt 7 ]]; then
    echo "Error: The first parameter must contain no more than 7 characters."
    exit 1
fi

# Проверка, что первый параметр содержит только буквы английского алфавита
if ! [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: The first parameter must contain only letters of the English alphabet."
    exit 1
fi


# Проверка имя.расширение
IFS='.' read -r -a name_ext <<< "$2"

# Проверка на наличие 'bin' или 'sbin' в пути:
if [[ "$2" == *"bin"* ]] || [[ "$2" == *"sbin"* ]]; then
    echo "Error: The path or filename must not contain 'bin' or 'sbin'."
    exit 1
fi

if [[ "${#name_ext[@]}" -ne 2 ]] || [[ "${#name_ext[0]}" -gt 7 ]] || [[ "${#name_ext[1]}" -gt 3 ]]; then
    echo "Error: The second parameter must be of format 'name.extension', with a maximum of 7 characters for name and 3 for extension."
    exit 1
fi

if ! [[ "${name_ext[0]}" =~ ^[a-zA-Z]+$ ]] || ! [[ "${name_ext[1]}" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: The second parameter must contain only letters of the English alphabet for both name and extension."
    exit 1
fi

# Проверка размера файла
if ! [[ "$3" =~ ^[0-9]+Mb$ ]]; then
    echo "Error: The third parameter must be a size in format '*Mb', where * is a number not exceeding 100."
    exit 1
fi

file_size_mb="${3%Mb}"

if (( file_size_mb == 0 )); then
    echo "Error: The file size must not be zero."
    exit 1
fi

if (( file_size_mb > 100 )); then
    echo "Error: The file size must not exceed 100Mb."
    exit 1
fi
