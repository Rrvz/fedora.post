#!/usr/bin/env bash

sudo dnf install bash-completion mlocate vim tmux net-tools -y

# Creation of bash script for Active network Interfaces
sudo bash -c "cat > /usr/local/sbin/monitor-interfaces.bash" <<-'EOF'
#!/usr/bin/env bash
_array_interfaces_0=( $(ls -1 /sys/class/net -I lo) )
_array_IPv6=( $(printf "\\\6{%s} - " "${_array_interfaces_0[@]}") )
_array_IPv4=( $(printf "\\\4{%s} - " "${_array_interfaces_0[@]}") )

bash -c "cat > /etc/issue" <<-IEOF_0
\S \l - Kernel \r on an \m

IPv6: ${_array_IPv6[@]}
IPv4: "${_array_IPv4[@]}

IEOF_0
EOF

# Monitor changes in the OS
sudo bash -c "cat > /usr/local/sbin/monitor-interfaces.bash" <<-'EOF'
#!/usr/bin/env bash

_file_0="/tmp/watchfile_0"
_commands_0="ls /sys/class/net/ -I lo"

[[ -f "${_file_0}" ]] || bash -c "${_commands_0}" > "${_file_0}"
[[ `cat "${_file_0}"` == `${_commands_0}` ]] \
    || bash /usr/local/sbin/monitor-interfaces.bash
bash -c "${_commands_0}" > "${_file_0}"
EOF

# Set permissions for the script files.
sudo chmod 744 /usr/local/sbin/monitor-interfaces.bash
sudo chmod 744 /usr/local/sbin/monitor-interfaces.bash

# Create systemd services for Active Interfaces
sudo bash -c "cat > /usr/lib/systemd/system/monitor-interfaces.service" <<-'EOF'
[Unit]
Description=Monitor network interfaces
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash /usr/local/sbin/monitor-interfaces.bash

[Install]
WantedBy=default.target
EOF

# Create Timer systemd to run the script and restart monitor interface service
sudo bash -c "cat > /etc/systemd/system/monitor-interfaces.timer" <<-'EOF'
[Unit]
Description=Timer to monitor network interfaces
After=default.target monitor-interfaces.service

[Timer]
OnCalendar=*:0/1
Unit=monitor-interfaces.service

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now monitor-interfaces.timer
# sudo systemctl status monitor-interfaces.timer -l --no-pager
