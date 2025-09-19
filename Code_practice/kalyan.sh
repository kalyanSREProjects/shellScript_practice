#!/bin/bash

# Set base path
BASE_PATH="/data/hypersycn/hsmvol"

# Prompt user for input date in format DD-MM-YYYY
echo "Please enter the date "
read DATE

# Check if the customer provided a date, otherwise use the current date
if [ -z "$DATE" ]; then
    # Get the current date in DD-MM-YYYY format
    CURRENT_DATE=$(date +%d-%m-%Y)
    LOG_BASE_PATH="${BASE_PATH}-${CURRENT_DATE}"
else
    LOG_BASE_PATH="${BASE_PATH}-${DATE}"
fi

# Display the constructed log path
echo "The log base path is: ${LOG_BASE_PATH}"
