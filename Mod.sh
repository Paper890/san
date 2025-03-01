#!/bin/bash
export TIME="10"
IP=$(curl -sS ipv4.icanhazip.com)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
domain=$(cat /etc/xray/domain)
clear
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "     Create SSH Ovpn Account      "
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p " Username       : " Login
read -p " Password       : " Pass
read -p " Expired (Days) : " masaaktif

clear
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`

DETAIL="
━━━━━━━━━━━━━━━━━
Username         : $Login
Password         : $Pass
Host             : $domain
━━━━━━━━━━━━━━━━━
Port SSL         : 443
Port Non SSL     : 80
UDP-Custom       : 1-65535
BadVPN UDP       : 7100, 7300, 7300
━━━━━━━━━━━━━━━━━
Aktif Selama     : $masaaktif Hari
Dibuat Pada      : $tnggl
Berakhir Pada    : $expe
━━━━━━━━━━━━━━━━━
"

echo -e "$DETAIL"
