#!/bin/bash

# Проверяем, что передано ровно 6 параметров
if [ "$#" -ne 6 ]; then
    echo "Error: Exactly 6 arguments are required."
    exit 1
fi

# Проверка, что первый параметр является абсолютным путем
if [[ "$1" != /* ]]; then
    echo "Error: The first parameter must be an absolute path."
    exit 1
fi

# Проверка, что указанный путь существует
if [ ! -e "$1" ]; then
    echo "Error: The path '$1' does not exist."
    exit 1
fi

# Проверка, что указанный путь является директорией (необязательная проверка)
if [ ! -d "$1" ]; then
    echo "Error: The path '$1' is not a directory."
fi

# Проверка, что второй параметр состоит из цифр
if ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "Error: The second parameter must be a digit."
    exit 1
fi

# Проверка, что второй параметр не равен нулю
if [ "$2" -eq 0 ]; then
    echo "Error: The second parameter must be greater than zero."
    exit 1
fi

# Проверка, что третий параметр содержит не более 7 знаков
if [[ "${#3}" -gt 7 ]]; then
    echo "Error: The third parameter must contain no more than 7 characters."
    exit 1
fi

# Проверка, что третий параметр содержит только буквы английского алфавита
if ! [[ "$3" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: The third parameter must contain only letters of the English alphabet."
    exit 1
fi

# Проверка, что четвертый параметр состоит из цифр

if ! [[ "$4" =~ ^[0-9]+$ ]]; then
    echo "Error: The fourth parameter must be a digit."
    exit 1
fi

# Проверка имя.расширение
IFS='.' read -r -a name_ext <<< "$5"
if [[ "${#name_ext[@]}" -ne 2 ]] || [[ "${#name_ext[0]}" -gt 7 ]] || [[ "${#name_ext[1]}" -gt 3 ]]; then
    echo "Error: The fifth parameter must be of format 'name.extension', with a maximum of 7 characters for name and 3 for extension."
    exit 1
fi

if ! [[ "${name_ext[0]}" =~ ^[a-zA-Z]+$ ]] || ! [[ "${name_ext[1]}" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: The fifth parameter must contain only letters of the English alphabet for both name and extension."
    exit 1
fi

# Проверка размера файла
if ! [[ "$6" =~ ^[0-9]+kb$ ]]; then
    echo "Error: The sixth parameter must be a size in format '*kb', where * is a number not exceeding 100."
    exit 1
fi

file_size_kb="${6%kb}"

if (( file_size_kb == 0 )); then
    echo "Error: The file size must not be zero."
    exit 1
fi

if (( file_size_kb > 100 )); then
    echo "Error: The file size must not exceed 100kb."
    exit 1
fi
