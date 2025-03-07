#!/bin/bash

read -rp "Input Username : " user
read -p "Expired (days): " masaaktif


    exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    
    sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    
