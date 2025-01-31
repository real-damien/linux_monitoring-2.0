#!/bin/bash

# Проверка количества аргументов
if [ "$#" -ne 0 ]; then
    echo "Error: This script does not take any parameters."
    exit 1
fi