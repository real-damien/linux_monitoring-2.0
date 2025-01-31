#!/bin/bash

# Проверка количества аргументов
if [ "$#" -ne 1 ]; then
    echo "Error: You must provide exactly one parameter."
    exit 1
fi

# Проверка, что параметр не является числом от 1 до 4
if [[ ! "$1" =~ ^[1-4]$ ]]; then
    echo "Error: Parameter must be a number between 1 and 4."
    exit 1
fi

