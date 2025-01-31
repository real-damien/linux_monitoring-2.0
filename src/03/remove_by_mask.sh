#!/bin/bash

current_date="$(date +%d%m%y)"

find /home/ -path "*_$current_date*" -delete
find /home/ -name "*_$current_date*" -delete

#Тест для папки ../02/
# find ../02/ -path "*_$current_date*" -delete
# find ../02/ -name "*_$current_date*" -delete

