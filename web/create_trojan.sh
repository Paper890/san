#!/bin/bash

domain=$(cat /etc/xray/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)

#━━━━━━━━━━━━━━━━━
read -rp "User: " -e user
read -p "Expired (days): " masaaktif	


tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

# Link Trojan Akun
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bugkamu.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"


systemctl reload xray
systemctl reload nginx
service cron restart
trojanlink="trojan://${uuid}@${domain}:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"


clear
━━━━━━━━━━━━━━━━━
Username          : ${user}
Host              : ${domain}
━━━━━━━━━━━━━━━━━
echo -e "port             : 400-900" 
echo -e "Key              : ${uuid}" 
echo -e "Path             : /trojan-ws" 
echo -e "ServiceName      : trojan-grpc" 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" 
echo -e "Link WS          : ${trojanlink}" 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" 
echo -e "Link GRPC        : ${trojanlink1}" 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" 
echo -e "Format OpenClash : https://${domain}:81/trojan-$user.txt" 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" 
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" 
echo "" 
