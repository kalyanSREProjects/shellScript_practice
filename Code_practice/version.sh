#!/bin/bash

TODAY=$(date +%d-%m-%Y)

LOG_LOCATION="/data/hypersync/logs/hsm1/feeder1/log-$TODAY"
LATEST_DIR=$(ls -td ${LOG_LOCATION}/* | sort -r | head -1)

HSM_HEALTH="/data/hypersync/logs/hsm1/hsmserver/hsm_health.log"

FC_LOG_LOCATION="/data/hypersync/logs/file-cacher/log-$TODAY"
FC_LATEST_DIR=$(ls -td ${FC_LOG_LOCATION}/* | sort -r | head -1)/bse_cm/Feeder.log

ITALIC="\e[3m"
RESET="\e[0m"

echo -e  "${ITALIC}HSI_Versions${RESET}"

grep -o '"hsiVersion":"[^"]*"' /data/hypersync/logs/hsi1/hsiserver/hsi_health.log | awk -F ':"' '{print $0}' |  tail -1
grep -o '"rrsVersion":"[^"]*"' /data/hypersync/logs/hsi1/hsiserver/hsi_health.log | awk -F ':"' '{print $0}' |  tail -1
grep -o '"adminApiVersion":"[^"]*"' /data/hypersync/logs/hsi1/hsiserver/hsi_health.log | awk -F ':"' '{print $0}' |  tail -1

echo

echo -e  "${ITALIC}HSM_Versions${RESET}"

HSM_Ver=$(grep -o 'HSM[^"]*,' "$HSM_HEALTH" | awk -F ':' '{print $2}' | cut -c -9 |  tail -1)
Admin_api_version=$(grep -o '<Api: Nest> <Ver: [^"]*>' "${LATEST_DIR}/Feeder"* | awk -F '<Ver: ' '{print $2}' |cut -c -9|  tail -1)
echo "Hsm_Version : $HSM_Ver"
echo "AdminApiVersion => $Admin_api_version"

echo

echo -e "${ITALIC}File_Cacher_Versions${RESET}"

File_cacher_version=$(grep -o 'hs-csv-nest:[^"]*' /home/hypersync/hs-deployments/file-cacher/docker-compose.yaml | awk -F ':' '{print $2}')
Fc_Admin_api_version=$(grep -o '<Api: Nest> <Ver: [^"]*>' "${FC_LATEST_DIR}" | awk -F '<Ver: ' '{print $2}'|cut -c -9)
echo "File_cacher_Version : $File_cacher_version"
echo "File_cacher_AdminApiVersion => $Fc_Admin_api_version"
echo












