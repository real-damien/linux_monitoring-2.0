#!/bin/bash

end_time_to_display=`date +%T`
echo "End time of the script: $end_time_to_display" >> "$log_file"
end_time=`date +%s`
runtime=$((end_time-start_time))
echo "Run time of the script: $runtime seconds" >> "$log_file"

echo "Start time = $start_time_to_display"
echo "End time = $end_time_to_display"
echo "Runtime = $runtime seconds"