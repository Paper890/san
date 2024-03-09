#!/bin/bash
# Fungsi input domain
function pasang_domain() {
echo -e ""
clear
    echo -e "   .----------------------------------."
echo -e "   |\e[1;32mPlease Select a Domain Type Below \e[0m|"
echo -e "   '----------------------------------'"
echo -e "     \e[1;32m1)\e[0m Enter Your Subdomain"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2 or Any Button(Random) : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   \e[1;32mPlease Enter Your Subdomain $NC"
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/kyt/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf
wget ${REPO}ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
print_install "Random Subdomain/Domain is Used"
wget ${REPO}cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
    fi
}

# Install dependencies
apt install -y wget screen
apt update -y && apt upgrade -y
apt install lolcat -y
gem install lolcat

# Download and run setup.sh
wget -q https://raw.githubusercontent.com/Paper890/san/main/getting.sh
chmod +x getting.sh
screen -S install ./getting.sh
