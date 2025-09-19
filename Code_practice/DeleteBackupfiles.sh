#!/bin/bash
#set the list of log location
LOG_LOCATIONS=(
    "/data/hypersync/hsmvol/backup" 
    )
#Log file for recording script activity 
LOG_FILE="/home/hypersync/hs-deployments/scripts/cleanup.log"

#Function to log messages
log_message()   {
    local log_msg="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $log_msg"
    echo "[$timestamp] $log_msg" >> "$LOG_FILE"
}
#Start logging
log_message "Log cleanup script started."

# Iterate over the log locations
for LOG_LOCATION in "${LOG_LOCATIONS[@]}"; do                   # This starts a loop. The loop will go through each item in the LOG_LOCATIONS array.

#check if the locaton exists
if [ -d "${LOG_LOCATION}" ];    then                # "-d" is a test option that returns "true" if the given path is a directory. If the directory exists, the script will proceed with the next step

# Find and delete files, logging the activity
find "${LOG_LOCATION}" -type f -print -exec rm -f {} \; -exec echo "Deleted file: {}" \; >> "$LOG_FILE" 2>&1
#The "find" command searches for all files "(-type f)" within the directory specified by LOG_LOCATION.
# '-print:' This option prints the path of each file found.
# '-exec rm -f {} \;' For each file found, the rm -f {} command deletes it. {} is a placeholder that represents each file found by find.

else 
    log_message "Directory does not exist: ${LOG_LOCATION}"
fi
done
# Finish logging
log_message "Log cleanup script completed."



