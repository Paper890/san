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
if [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
fi

if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/kyt/limit/trojan/ip
echo -e "$iplimit" > /etc/kyt/limit/trojan/ip/$user
else
echo > /dev/null
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/trojan/${user}
fi
DATADB=$(cat /etc/trojan/.trojan.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
fi
echo "### ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/trojan/.trojan.db
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
clear
cd acc
nama_file="${user}.txt"

echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e " CREATE TROJAN ACCOUNT          " >> "$nama_file"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Remarks          : ${user}"  >> "$nama_file"
echo -e "Host/IP          : ${domain}" >> "$nama_file"
#echo -e "User Quota       : ${Quota} GB" >> "$nama_file"
#echo -e "User Ip           : ${iplimit} IP" >> "$nama_file"
echo -e "port             : 400-900"  >> "$nama_file"
echo -e "Key              : ${uuid}" >> "$nama_file"
echo -e "Path             : /trojan-ws" >> "$nama_file" 
echo -e "ServiceName      : trojan-grpc" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Link WS          : ${trojanlink}"  >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"  >> "$nama_file"
echo -e "Link GRPC        : ${trojanlink1}" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Format OpenClash : https://${domain}:81/trojan-$user.txt" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Aktif Selama     : $masaaktif Hari" >> "$nama_file"
echo -e "Dibuat Pada      : $tnggl" >> "$nama_file"
echo -e "Berakhir Pada    : $expe" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo "" 

clear
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e " CREATE TROJAN ACCOUNT          "
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks          : ${user}" 
echo -e "Host/IP          : ${domain}"
#echo -e "User Quota       : ${Quota} GB"
#echo -e "User Ip           : ${iplimit} IP"
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
