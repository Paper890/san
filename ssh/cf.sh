#!/bin/bash
#Ambil informasi IP
IP=$( curl -sS ipinfo.io/ip )
clear
echo -e "---------------------------------------------------"
echo -e "     _______   _  __  ______________  ___  ____    "
echo -e "    / __/ _ | / |/ / / __/_  __/ __ \/ _ \/ __/    "
echo -e "   _\ \/ __ |/    / _\ \  / / / /_/ / , _/ _/      "
echo -e "  /___/_/ |_/_/|_/ /___/ /_/  \____/_/|_/___/      "
echo -e "                                                   "
echo -e "          BUY PERMISION : 085155208019             "
echo -e "---------------------------------------------------"
echo ""
echo "Masukkan subdomain | Contoh : bebas (no space)"
        read -p "Input subdomain : " subdomain

# Set Cloudflare API credentials
CF_API_KEY="ea6a937332a2f01d2d22d495dafdfbd187cd3"
CF_API_EMAIL="hasdararysandhy@gmail.com"
CF_ZONE_ID="a7f2d5c805f97a037afefa9f16421a7f"

# Set domain and DNS record details
DOMAIN="kakaonet.my.id"
RECORD_NAME="$subdomain"
RECORD_IP="$IP"

#Ambil informasi full domain
export host1=$subdomain.kakaonet.my.id

# Disable Cloudflare proxy status for the domain
curl -X PATCH "https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records?type=A&name=$RECORD_NAME.$DOMAIN" \
     -H "X-Auth-Email: $CF_API_EMAIL" \
     -H "X-Auth-Key: $CF_API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"proxied":false}'

# Add DNS record type A for the domain
curl -X POST "https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records" \
     -H "X-Auth-Email: $CF_API_EMAIL" \
     -H "X-Auth-Key: $CF_API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'$RECORD_NAME'.'$DOMAIN'","content":"'$RECORD_IP'","ttl":1,"proxied":false}'
