#!/bin/bash

BASE_PATH="/data/hypersync/logs/hsi2/hsiserver"

#For specific date
TODAY="09-12-2024"
TODAY_YMD="20241209"

#FOR current date
#TODAY=$(date +%d-%m-%Y)

#TODAY_YMD=$(date +%Y%m%d)

LOG_BASE_PATH="${BASE_PATH}/log-${TODAY}"

# Identify restart-time directories
RESTART_DIRS=$(ls -d ${LOG_BASE_PATH}/*/ | sort -r )

# Validate presence of directories
if [ -z "$RESTART_DIRS" ]; then
    echo "No restart directories found for today's date in $LOG_BASE_PATH."
    exit 1
fi

# Select the latest restart directory based on name
LATEST_DIR=$(echo "$RESTART_DIRS" | sort | tail -1)


if [ ! -d "$LATEST_DIR" ]; then
    echo "No log directory found for today's date: $LATEST_DIR."
    exit 1
fi

cd $LATEST_DIR 

> "$OUTPUT_FILE"

OUTPUT_FILE="/home/hypersync/hs-deployment/test/rtou_report_${TODAY}.txt"



{
    for interval in {15...45}; do
        zgrep "${TODAY_YMD} 09:${interval}".*."type\":\"order" "${LATEST_DIR}/ws_updates-${TODAY}-09"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
    for interval in {00...30}; do
        zgrep "${TODAY_YMD} 12:${interval}".*."type\":\"order" "${LATEST_DIR}/ws_updates-${TODAY}-12"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
    for interval in {00...30}; do
        zgrep "${TODAY_YMD} 15:${interval}".*."type\":\"order" "${LATEST_DIR}/ws_updates-${TODAY}-15"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
    for interval in {15...45}; do
        zgrep "${TODAY_YMD} 09:${interval}".*."type\":\"position" "${LATEST_DIR}/ws_updates-${TODAY}-09"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
    for interval in {00...30}; do
        zgrep "${TODAY_YMD} 12:${interval}".*."type\":\"position" "${LATEST_DIR}/ws_updates-${TODAY}-12"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
    for interval in {00...30}; do
        zgrep "${TODAY_YMD} 15:${interval}".*."type\":\"position" "${LATEST_DIR}/ws_updates-${TODAY}-15"* | wc -l | xargs -I {} 
        echo "Orders updates sent at ${TODAY} 09:${interval} - Count:{}"
    done
    echo --------------------------------------------------------------------------------
} > "$OUTPUT_FILE"
echo "RTOU bandwith report completed. Results saved in $OUTPUT_FILE. "