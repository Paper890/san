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
trojanlink="trojan://${uuid}@${domain}:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"

systemctl restart xray
systemctl reload xray
systemctl reload nginx
service cron restart

clear
DETAIL="
━━━━━━━━━━━━━━━━━
Username          : ${user}
Host              : ${domain}
━━━━━━━━━━━━━━━━━
port             : 443
Key              : ${uuid}
Path             : /trojan-ws
ServiceName      : trojan-grpc
━━━━━━━━━━━━━━━━━
Link WS          : 
${trojanlink}

Link GRPC        : 
${trojanlink1}
━━━━━━━━━━━━━━━━━
Aktif Selama     : $masaaktif Hari
Dibuat Pada      : $tnggl
Berakhir Pada    : $expe
"
echo -e "$DETAIL"
