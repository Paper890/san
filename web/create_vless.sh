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
DETAIL="
━━━━━━━━━━━━━━━━━
Remarks     : ${user}
Domain      : ${domain}
━━━━━━━━━━━━━━━━━
port TLS    : 443
Port NTLS   : 80
User ID     : ${uuid}
Path TLS    : /vless & /vless-grpc"
━━━━━━━━━━━━━━━━━
Link TLS    : 
${vlesslink1}

Link NTLS   : 
${vlesslink2}

Link GRPC   : 
${vlesslink3}
━━━━━━━━━━━━━━━━━
Aktif Selama     : $masaaktif Hari
Dibuat Pada      : $tnggl
Berakhir Pada    : $expe
━━━━━━━━━━━━━━━━━
"
echo -e "${DETAIL}"
