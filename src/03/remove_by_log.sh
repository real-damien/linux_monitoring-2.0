#!/bin/bash

file=../02/log_file.log
echo "Cleaning by log file $file"

folder_path="$(cat $file | awk -F ' ' '{print $3}')"

echo $folder_path
regex='^\/'

for folder in $folder_path
do
	if [[ $folder =~ $regex ]]
	then
		sudo rm -r $folder &> /dev/null
	fi
done

> "$file"