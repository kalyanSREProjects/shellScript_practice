#!/bin/bash

BASE_PATH="/data/hypersync/logs/hsi/hsiserver/hsi_health.log"
TODAY=$(date +%Y%m%d)

echo "Enter the Time"
read TIME

zgrep "${TODAY} ${TIME}".*."usedPercent" "${BASE_PATH}" | head -1 | awk -F ',' '
{
    for (i=1; i<=NF; i++)                                               # NF => Next field
    {
        if ($i ~ /dateTime/ || $i ~ /usedPercent/ )                     # /dateTime/ for finding in b/w slash keyword, "||" logical or operator
        {
            printf "%s", $i, $(i+1)                                     # printf printing the o/p, "%s" indicates having string,    
        }
    }
}'
echo
zgrep "${TODAY} ${TIME}".*."activeWSConnections" "${BASE_PATH}" | head -1 | awk -F ',' '
{
    for (i=1; i<=NF; i++) 
    {
        if ($i ~ /dateTime/ || $i ~ /currentLoggedInUsers/ ||  $i ~ /activeWSConnections/ ) 
        {
            printf "%s", $i, $(i+1)
        }
    }
}'
echo 


## cut -d "," -f 10,21 trade_report.log => It will filter the fields which is seperated by , and mentioned particular fields only.






















