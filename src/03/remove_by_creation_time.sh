#!/bin/bash

echo "Specify timeframe for deletion."

echo "Start date (e.g., 18 Jan 2025 12:00):"
read start

if [ -z "$start" ]; then
  echo "Start date is required. Try again."
  exit 1
fi

echo "End date (e.g., 18 Jan 2025 12:30):"
read end

if [ -z "$end" ]; then
  echo "End date is required. Try again."
  exit 1
fi

find /home/ -type f -newermt "$start:00" ! -newermt "$end:00" -delete &> /dev/null
find /home/ -type d -empty -newermt "$start:00" ! -newermt "$end:00" -delete &> /dev/null

#Тесты для папки ../02/
# find ../02/ -type f -newermt "$start:00" ! -newermt "$end"
# find ../02/ -type f -newermt "$start:00" ! -newermt "$end:00" -delete &> /dev/null

# find ../02/ -type d -newermt "$start:00" ! -newermt "$end"
# find ../02/ -type d -empty -newermt "$start:00" ! -newermt "$end:00" -delete &> /dev/null
