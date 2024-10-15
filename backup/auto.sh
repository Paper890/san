#!/bin/bash

# Minta token bot dan chat ID dari pengguna
read -p "Masukkan Token Bot Telegram Anda: " BOT_TOKEN
read -p "Masukkan Chat ID Telegram Anda: " CHAT_ID

# Perbarui paket dan instal Python3-pip jika belum ada
apt-get update
apt-get install -y python3-pip

# Instal modul Python yang diperlukan
pip3 install requests
pip3 install schedule
pip3 install pyTelegramBotAPI

# Buat direktori proyek
mkdir -p /opt/autobackup
cd /opt/autobackup

# Buat file script python
cat <<EOF > auto.py
import os
import shutil
import zipfile
import requests
import schedule
import time
import threading
import telebot
from datetime import datetime

# Informasi bot Telegram
bot_token = "${BOT_TOKEN}"
chat_id = "${CHAT_ID}"
bot = telebot.TeleBot(bot_token)

# Lokasi direktori dan file/folder yang ingin disalin
src_dir = "/etc/"
files_to_copy = ["passwd", "group", "shadow", "gshadow"]
folder_to_copy = "xray"
destination_dir = "/tmp/backup"
restore_dir = "/etc/"

def copy_files_and_folder():
    if os.path.exists(destination_dir):
        shutil.rmtree(destination_dir)
    os.makedirs(destination_dir, exist_ok=True)

    for file in files_to_copy:
        shutil.copy2(os.path.join(src_dir, file), destination_dir)

    src_folder_path = os.path.join(src_dir, folder_to_copy)
    dest_folder_path = os.path.join(destination_dir, folder_to_copy)
    shutil.copytree(src_folder_path, dest_folder_path)

def create_zip():
    now = datetime.now()
    zip_filename = os.path.join(destination_dir, f"Tanggal_{now.strftime('%Y-%m-%d')}.zip")
    with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(destination_dir):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, destination_dir)
                zipf.write(file_path, arcname)
    return zip_filename

def send_to_telegram(file_path):
    url = f"https://api.telegram.org/bot{bot_token}/sendDocument"
    with open(file_path, 'rb') as f:
        files = {'document': f}
        data = {'chat_id': chat_id, 'caption': 'Backup Succes\nLakukan Restart All Service & Pointing Domain kembali setelah Melakukan Restore'}
        response = requests.post(url, files=files, data=data)
    if response.status_code == 200:
        print("File sent successfully")
    else:
        print(f"Failed to send file: {response.text}")

def job():
    copy_files_and_folder()
    zip_filename = create_zip()
    send_to_telegram(zip_filename)

schedule.every(60).minutes.do(job)

def restore_backup(zip_filepath):
    with zipfile.ZipFile(zip_filepath, 'r') as zip_ref:
        zip_ref.extractall("/tmp/restore")

    for file in ["passwd", "group", "shadow", "gshadow"]:
        shutil.copy2(os.path.join("/tmp/restore", file), restore_dir)

    folder_to_copy = "xray"
    src_folder_path = os.path.join("/tmp/restore", folder_to_copy)
    dest_folder_path = os.path.join(restore_dir, folder_to_copy)

    if os.path.exists(dest_folder_path):
        shutil.rmtree(dest_folder_path)
    shutil.copytree(src_folder_path, dest_folder_path)

    shutil.rmtree("/tmp/restore")

@bot.message_handler(content_types=['document'])
def handle_docs(message):
    try:
        file_info = bot.get_file(message.document.file_id)
        downloaded_file = bot.download_file(file_info.file_path)

        zip_filepath = os.path.join("/tmp", message.document.file_name)
        with open(zip_filepath, 'wb') as new_file:
            new_file.write(downloaded_file)

        restore_backup(zip_filepath)
        os.remove(zip_filepath)

        bot.reply_to(message, "Restore completed successfully.")
    except Exception as e:
        bot.reply_to(message, f"Restore failed: {e}")

# Mengaktifkan bot Telegram
bot_thread = threading.Thread(target=lambda: bot.polling(none_stop=True))
bot_thread.start()

print("Script is running...")

while True:
    schedule.run_pending()
    time.sleep(1)
EOF

# Buat file service systemd
cat <<EOF > /etc/systemd/system/auto.service
[Unit]
Description=Backup and Restore Bot Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/autobackup/auto.py
WorkingDirectory=/opt/autobackup
StandardOutput=inherit
StandardError=inherit
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd dan mulai service
systemctl daemon-reload
systemctl enable auto
systemctl start auto

echo "Autobackup Berhasil Di install" 

cd
rm auto.sh
