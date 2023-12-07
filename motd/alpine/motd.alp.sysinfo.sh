#!/bin/sh

echo " "
echo "[ ———————————— SYSTEM LOAD ———————————— ]"
echo "$(uptime)"

echo " "
echo "[ ———————————— CPU INFO ——————————————— ]"
cpu_info=$(cat /proc/cpuinfo) # assuming cpu_info is populated like this

# Extracting specific fields
processor_id=$(echo "$cpu_info" | grep -m 1 'processor' | awk '{print $3}')
vendor_id=$(echo "$cpu_info" | grep -m 1 'vendor_id' | awk '{print $3}')
cpu_family=$(echo "$cpu_info" | grep -m 1 'cpu family' | awk '{print $4}')
model=$(echo "$cpu_info" | grep -m 1 'model\t' | awk '{print $3}')
model_name=$(echo "$cpu_info" | grep -m 1 'model name' | cut -d ':' -f 2 | xargs)
cpu_mhz=$(echo "$cpu_info" | grep -m 1 'cpu MHz' | awk '{print $4}')
cache_size=$(echo "$cpu_info" | grep -m 1 'cache size' | cut -d ':' -f 2 | xargs)
cpu_cores=$(echo "$cpu_info" | grep -m 1 'cpu cores' | awk '{print $4}')
core_id=$(echo "$cpu_info" | grep -m 1 'core id' | awk '{print $4}')
address_sizes=$(echo "$cpu_info" | grep -m 1 'address sizes' | cut -d ':' -f 2 | xargs)

# Format and display the extracted information in columns
printf "%-20s %s\n" "Processor ID:" "$processor_id"
printf "%-20s %s\n" "CPU Cores:" "$cpu_cores"
printf "%-20s %s\n" "Core ID:" "$core_id"
printf "%-20s %s\n" "Vendor ID:" "$vendor_id"
printf "%-20s %s\n" "Model Name:" "$model_name"
printf "%-20s %s\n" "CPU Family:" "$cpu_family"
printf "%-20s %s\n" "Model:" "$model"
printf "%-20s %s\n" "CPU MHz:" "$cpu_mhz"
printf "%-20s %s\n" "Cache Size:" "$cache_size"
printf "%-20s %s\n" "Address Sizes:" "$address_sizes"

echo " "
echo "[ ———————————— MEMORY USAGE ———————————— ]"
echo "$(free -h)"

echo " "
echo "[ ———————————— DISK USAGE —————————————— ]"
echo "$(df -h)"
echo " "

# Check for the existence of necessary commands
# if command -v uptime > /dev/null && command -v free > /dev/null && command -v df > /dev/null; then
#     echo "\nSystem Load: $(uptime)\n\nFree Memory: $(free -h)\n\nDisk Usage: $(df -h)\n"
# else
#     echo "Required commands not available."
# fi
