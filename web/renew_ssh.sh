#!/bin/bash

# Cek hak akses root
if [ "$(id -u)" != "0" ]; then
  echo "Script harus dijalankan sebagai root!"
  exit 1
fi

# Input informasi
read -p "Username : " User
read -p "Tambah masa aktif (hari): " Days

# Validasi input
if ! id "$User" &>/dev/null; then
  echo "User '$User' tidak ditemukan!"
  exit 1
fi

if ! [[ "$Days" =~ ^[0-9]+$ ]]; then
  echo "Input 'Day Extend' harus berupa angka positif!"
  exit 1
fi

# Ambil tanggal expired saat ini
current_expire=$(chage -l "$User" | grep 'Account expires' | awk -F': ' '{print $2}')
if [[ "$current_expire" == "never" ]]; then
  echo "Akun '$User' tidak memiliki tanggal kedaluwarsa."
  exit 1
fi

# Konversi tanggal expired saat ini ke timestamp
current_expire_timestamp=$(date -d "$current_expire" +%s)

# Hitung tanggal baru
new_expire_timestamp=$((current_expire_timestamp + Days * 86400))
new_expire=$(date -d "@$new_expire_timestamp" +"%Y-%m-%d")
new_expire_display=$(date -d "@$new_expire_timestamp" +"%d %b %Y")

# Perbarui tanggal expired
usermod -e "$new_expire" "$User"
