#!/bin/bash

#Select log location
LOG_LOCATIONS=(
    "/data/hypersync/hsmvol/backup"
)
#Log file for recording script activity
LOG_PATH="/home/hypersync/hs-deployments/scripts/cleaup.log"

#Function to log_message
log_message(){
    local log_msg="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $log_msg"
    echo "[$timestamp] $log_msg" >> "$LOG_PATH"
}

#start logging
log_message "Log cleanup script started."

#Iterate over the log location
for LOG_LOCATION in "${LOG_LOCATIONS[@]}" ; do

#CHECK IF THE LOCATION EXISTS
if [-d "${LOG_LOCATION}" ]; then

#FIND AND DELETE FILES, LOGGING THE ACTIVITY
find "${LOG_LOCATIONS}" -type f -print -exec rm -r {} \; -exec echo "Deleted file : {}"  \; >> "$LOG_PATH" 2>&1
else
    log_message "Directory does not exist: ${LOG_LOCATION}"
fi
done

#Finish logging
log_message "Log cleanup script completed."


