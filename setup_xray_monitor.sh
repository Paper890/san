#!/bin/bash

# Fungsi untuk menampilkan pesan sukses atau error
log_success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

log_error() {
    echo -e "\e[31m[ERROR]\e[0m $1"
}

# Langkah 1: Buat script xray_monitor.sh
SCRIPT_PATH="/usr/local/bin/xray_monitor.sh"

cat <<EOF > "$SCRIPT_PATH"
#!/bin/bash

# Fungsi untuk mendapatkan status layanan Xray
check_xray_status() {
    xray_service=\$(systemctl status xray | grep Active | awk '{print \$3}' | cut -d "(" -f2 | cut -d ")" -f1)
    echo "\$xray_service"
}

# Fungsi utama
main() {
    # Mendapatkan status layanan Xray
    status=\$(check_xray_status)

    # Memeriksa apakah layanan sedang berjalan
    if [[ "\$status" == "running" ]]; then
        echo "\$(date): Xray service is running. No action needed."
    else
        echo "\$(date): Xray service is not running. Attempting to restart..."
        
        # Restart layanan Xray
        systemctl restart xray
        
        # Periksa kembali status setelah restart
        sleep 2 # Tunggu beberapa detik agar proses restart selesai
        new_status=\$(check_xray_status)
        
        if [[ "\$new_status" == "running" ]]; then
            echo "\$(date): Xray service has been successfully restarted and is now running."
        else
            echo "\$(date): Failed to restart Xray service. Please check the logs for more details."
        fi
    fi
}

# Jalankan fungsi utama
main
EOF

# Berikan izin eksekusi pada script
chmod +x "$SCRIPT_PATH"
log_success "Script xray_monitor.sh berhasil dibuat di $SCRIPT_PATH"

# Langkah 2: Buat file systemd service
SERVICE_FILE="/etc/systemd/system/xray-monitor.service"

cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=Xray Monitoring Service
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash $SCRIPT_PATH
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

log_success "File systemd service berhasil dibuat di $SERVICE_FILE"

# Langkah 3: Buat file systemd timer
TIMER_FILE="/etc/systemd/system/xray-monitor.timer"

cat <<EOF | sudo tee "$TIMER_FILE" > /dev/null
[Unit]
Description=Run Xray Monitoring Service Every Minute

[Timer]
OnCalendar=*-*-* *:*:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

log_success "File systemd timer berhasil dibuat di $TIMER_FILE"

# Langkah 4: Reload systemd, aktifkan, dan jalankan timer
sudo systemctl daemon-reload
sudo systemctl enable xray-monitor.timer
sudo systemctl start xray-monitor.timer

log_success "Systemd timer xray-monitor.timer telah diaktifkan dan dijalankan."

# Langkah 5: Verifikasi
echo "Verifikasi status timer:"
systemctl list-timers --all | grep xray-monitor

echo "Setup selesai! Script monitoring Xray akan berjalan setiap menit."
