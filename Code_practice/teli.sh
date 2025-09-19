#!/bin/bash

# Define the base path
BASE_PATH="/data/hypersync/logs/hsi1/hsiserver"

echo "Please enter date"
read DATE

if [ -z "$DATE" ]; then
    TODAY=$(date +%d-%m-%Y)
    LOG_BASE_PATH="${BASE_PATH}/log-${TODAY}"
else
    LOG_BASE_PATH="${BASE_PATH}/log-${DATE}"
fi

LATEST_DIR=$(ls -td ${LOG_BASE_PATH}/*/ | head -1)

if [ ! -d "$LATEST_DIR" ]; then
    echo "No log directory found for date: $LATEST_DIR."
    exit 1
fi

cd $LATEST_DIR

# Output file path for report
OUTPUT_FILE="/data/hypersync/logs/hsii/hsiserver/log-$(date +%d-%m-%Y)/ftou_report_$(date +%d-%m-%Y).txt"

# Fetch logs for the last 3 days
    # For loop to search logs for the time intervals (09:15 to 09:45)
    for interval in {15..45}; do
        zgrep "${LOG_DATE} 09:${interval}:.*.\"type\":\"order\"" "${LATEST_DIR}/ws_updates.log" | wc -l | xargs -I {} echo "Orders updates sent at ${LOG_DATE} 09:${interval} - Count: {}"
    done

    echo "-------------------------------------------" >> "$OUTPUT_FILE"
done

echo "===================================="
echo "#FJOD bandwidth report completed"
