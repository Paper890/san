#!/bin/bash
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);

#━━━━━━━━━━━━━━━━━
read -p "Username : " User
read -p "Day Extend : " Days

egrep "^$User" /etc/passwd >/dev/null

Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
