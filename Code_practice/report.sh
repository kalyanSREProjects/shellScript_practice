#!/bin/bash

DATE="19-03-2025"
#DATE=`date +%d-%m-%y`

cd test
mkdir $DATE 
cd $DATE
BASE_PATH1="/data/hypersync/logs/hsi1/"
BASE_PATH2="/data/hypersycn/logs/hsi2/"

HSI_TEMP_PATH1="${BASE_PATH1}hsiserver/log-$DATE"
HSI_TEMP_PATH2="${BASE_PATH2}hsiserver/log-$DATE"

RRS_TEMP_PATH1="${BASE_PATH1}rrs/log-$DATE"
RRS_TEMP_PATH2="${BASE_PATH2}rrs/log-$DATE"

touch FinalReport.txt

echo "-------------PATHS-------------------" > FinalReport.txt
echo $HSI_TEMP_PATH1 > FinalReport.txt
echo $HSI_TEMP_PATH2 > FinalReport.txt
echo $RRS_TEMP_PATH1 > FinalReport.txt
echo $RRS_TEMP_PATH2 > FinalReport.txt

find $HSI_TEMP_PATH1 find -type f -print0 | while IFS= read -r -d $'\0' filename;
do
if [[ "$filename" == *"response"* ]];
then 
    zgrep -i 'place.*"os":"MOB".*nOrdNo' $filename >> mob_order_del_identifier.log
    zgrep -i 'place.*"os":"WEB".*nOrdNo' $filename >> web_orders_del_identifier.log
    zgrep -i 'place.*"os":"TRADEAPI".*nOrdNo' $filename >> tradeapi_orders_del_identifier.log
    zgrep -i 'place.*"os":.*nOrdNo' $filename >> all_orders_del_identifier.log
    zgrep -ih "client registered successfully" $filename >> login_users_del_identifier.log
    echo "$filename"
fi
done
ind $RRS_TEMP_PATH1 find -type f -print0 | while IFS= read -r -d $'\0' filename;
do
if [[ "$filename" == *"subscribe_updates"* ]];
then
    grep -i "FillReport" $filename >> trade_reports_del_identifier.log
    echo "$file_name"
fi
done