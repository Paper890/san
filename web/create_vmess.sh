#!/bin/bash
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
# Getting
CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/Paper890/san/main/izin"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}
checking_sc
echo -e "\e[32mloading...\e[0m"
clear
source /var/lib/kyt/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

#tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
#none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "CREATE VMESS ACCOUNT           "
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
            echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
            echo -e " CREATE VMESS ACCOUNT           "
            echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"

			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
      menu
		fi
	done
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
#read -p "Limit User (GB): " Quota
#read -p "Limit User (IP): " iplimit
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1


cat >/var/www/html/vmess-$user.txt <<-END

◇━━━━━━━━━━━━━━━━━◇
# Format Vmess WS TLS

- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS

- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC

- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc

━━━━━━━━━━━━━━━━━
 Link Akun Vmess                   
━━━━━━━━━━━━━━━━━
Link TLS         : 
${vmesslink1}
━━━━━━━━━━━━━━━━━
Link none TLS    : 
${vmesslink2}
━━━━━━━━━━━━━━━━━
Link GRPC        : 
${vmesslink3}
━━━━━━━━━━━━━━━━━

END
if [ ! -e /etc/vmess ]; then
  mkdir -p /etc/vmess
fi

if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/kyt/limit/vmess/ip
echo -e "$iplimit" > /etc/kyt/limit/vmess/ip/$user
else
echo > /dev/null
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vmess/${user}
fi
DATADB=$(cat /etc/vmess/.vmess.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vmess/.vmess.db
fi
echo "### ${user} ${exp} ${uuid} ${Quota} ${iplimit}" >>/etc/vmess/.vmess.db
clear
cd acc
nama_file="${user}.txt"

echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e " Xray/Vmess Account " >> "$nama_file"
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Remarks          : ${user}" >> "$nama_file"
echo -e "Domain           : ${domain}" >> "$nama_file"
#echo -e "User Quota       : ${Quota} GB" >> "$nama_file"
#echo -e "User Ip          : ${iplimit} IP" >> "$nama_file"
echo -e "Port TLS         : 400-900" >> "$nama_file"
echo -e "Port none TLS    : 80, 8080, 8081-9999" >> "$nama_file"
echo -e "id               : ${uuid}" >> "$nama_file"
echo -e "alterId          : 0" >> "$nama_file"
echo -e "Security         : auto" >> "$nama_file"
echo -e "Network          : ws" >> "$nama_file"
echo -e "Path             : /Multi-Path" >> "$nama_file"
echo -e "Dynamic          : https://bugmu.com/path" >> "$nama_file"
echo -e "ServiceName      : vmess-grpc" >> "$nama_file"
#echo -e "Host XrayDNS : ${NS}"
#echo -e "Location         : $CITY"
#echo -e "Pub Key          : ${PUB}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Link TLS         : ${vmesslink1}" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Link none TLS    : ${vmesslink2}" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Link GRPC        : ${vmesslink3}" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Format OpenClash : https://${domain}:81/vmess-$user.txt" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo -e "Aktif Selama     : $masaaktif Hari" >> "$nama_file"
echo -e "Dibuat Pada      : $tnggl" >> "$nama_file"
echo -e "Berakhir Pada    : $expe" >> "$nama_file"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m" >> "$nama_file"
echo ""

clear
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Xray/Vmess Account "
echo -e "\033[1;93m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks          : ${user}"
echo -e "Domain           : ${domain}"
#echo -e "User Quota       : ${Quota} GB"
#echo -e "User Ip          : ${iplimit} IP"
echo -e "Port TLS         : 400-900"
echo -e "Port none TLS    : 80, 8080, 8081-9999"
echo -e "id               : ${uuid}"
echo -e "alterId          : 0"
echo -e "Security         : auto"
echo -e "Network          : ws"
echo -e "Path             : /Multi-Path"
echo -e "Dynamic          : https://bugmu.com/path"
echo -e "ServiceName      : vmess-grpc"
#echo -e "Host XrayDNS : ${NS}"
#echo -e "Location         : $CITY"
#echo -e "Pub Key          : ${PUB}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS         : ${vmesslink1}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link none TLS    : ${vmesslink2}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link GRPC        : ${vmesslink3}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Format OpenClash : https://${domain}:81/vmess-$user.txt"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━\033[0m"
echo ""
