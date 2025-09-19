#!/bin/bash

USE_YESTERDAY=true

echo "please enter date"
read DATE

if [ "$USE_YESTERDAY" = true ]; then
    TODAY_YMD=${DATE}
    echo "${TODAY_YMD}"
else 
    TODAY_YMD=$(date +%Y%m%d)
fi