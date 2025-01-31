while true; do
  {
    echo "# HELP cpu_used_in_percent The total CPU used as percent value"
    echo "# TYPE cpu_used_in_percent gauge"
    echo "cpu_used_in_percent $(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')"

    echo "# HELP free_hd_space_in_bytes The total number of bytes free in home directory"
    echo "# TYPE free_hd_space_in_bytes gauge"
    echo "free_hd_space_in_bytes $(df -B1 /home | awk 'NR==2{print $4}')"

    echo "# HELP free_mem_in_bytes The free RAM left in bytes"
    echo "# TYPE free_mem_in_bytes gauge"
    echo "free_mem_in_bytes $(free -b | awk 'NR==2{print $4}')"
  } > /var/www/html/metrics/index.html

  sleep 5
done