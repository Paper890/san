#!/bin/bash


domain=$(cat /etc/xray/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)
clear

#━━━━━━━━━━━━━━━━━
read -p "User: " -e user
read -p "Expired (days): " masaaktif



tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

systemctl restart xray
systemctl restart nginx
clear


clear
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e " CREATE VLESS ACCOUNT           "
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks     : ${user}"
echo -e "Domain      : ${domain}"
#echo -e "User Quota  : ${Quota} GB"
#echo -e "User Ip     : ${iplimit} IP"
echo -e "port TLS    : 400-900"
#echo -e "Port DNS    : 443"
echo -e "Port NTLS   : 80, 8080, 8081-9999"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Path TLS    : /vless "
echo -e "ServiceName : vless-grpc"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS    : ${vlesslink1}"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link NTLS   : ${vlesslink2}"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link GRPC   : ${vlesslink3}"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Format OpenClash : https://${domain}:81/vless-$user.txt"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
