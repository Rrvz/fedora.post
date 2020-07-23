#!/usr/bin/env bash

sudo dnf install bash-completion mlocate vim -y

# Creation of bash script for Active network Interfaces
sudo bash -c "cat > /usr/local/sbin/active-interfaces.bash" <<-'EOF'
#!/usr/bin/env bash
active-interfaces=( $(ls -1 /sys/class/net -I lo) )
    ArrayIPv6=( $(printf "\\\6{%s} - " "${active-interfaces[@]}") )
    ArrayIPv4=( $(printf "\\\4{%s} - " "${active-interfaces[@]}") )

echo "\S \l
Kernel \r on an \m

IPv6: "${ArrayIPv6[@]}"
IPv4: "${ArrayIPv4[@]}"
" > /etc/issue
EOF

# monitor changes in the OS
sudo bash -c "cat > /usr/local/sbin/monitor-interfaces.bash" <<-EOF
#!/usr/bin/env bash

_file_0="/tmp/watchfile0"
_file_1="/tmp/watchfile1"
_commands_0="ls /sys/class/net/ -I lo"

[[ -f "${_file_0}" ]] || sudo bash -c "${_commands_0} > ${_file_0}"
sudo bash -c "${_commands_0} > ${_file_1}"
sudo diff -q ${_file_0} ${_file_1} > /dev/null
if [ $? -ne 0 ] ; then
    sudo bash /usr/local/sbin/active-interfaces.bash
fi
sudo cp -r ${_file_1} ${_file_0}
EOF

sudo chmod 744 /usr/local/sbin/active-interfaces.bash
sudo chmod 744 /usr/local/sbin/monitor-interfaces.bash


# Create systemd services for Active Interfaces
sudo bash -c "cat > /usr/lib/systemd/system/active-interfaces.service" <<-'EOF'
[Unit]
Description=Active network interfaces
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash /usr/local/sbin/active-interfaces.bash

[Install]
WantedBy=default.target
EOF

# Create Timer systemd to run the script and the service
sudo bash -c "cat > /etc/systemd/system/active-interfaces.timer" <<-'EOF'
[Unit]
Description=Monitor network interfaces
After=default.target active-interfaces.service

[Timer]
OnCalendar=*:*:0/10
Unit=active-interfaces.service

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl restart active-interfaces.service
sudo systemctl restart active-interfaces.timer

#bash permissions

# sudo chmod 755 /usr/lib/systemd/system/active-interfaces.service
sudo systemctl daemon-reload
sudo systemctl enable --now active-interfaces.service
# sudo systemctl stop active-interfaces.service
# sudo systemctl restart active-interfaces.service
sudo systemctl status active-interfaces.service -l --no-pager

# sudo chmod 644 /etc/systemd/system/active-interfaces.timer
sudo systemctl daemon-reload
sudo systemctl enable --now active-interfaces.timer
# sudo systemctl stop active-interfaces.timer
# sudo systemctl restart active-interfaces.timer
sudo systemctl status active-interfaces.timer -l --no-pager


#Change ssh_host keys

sudo bash -c "cat > /usr/local/sbin/CloneVM-SSH.bash" <<-"EOF"
#!/usr/bin/env bash
sudo /bin/rm -fr /etc/ssh/ssh_host_*
sudo systemctl restart sshd
sudo rm -rf /root/.ssh/id_rsa
sudo rm -rf /root/.ssh/id_rsa.pub
sudo bash -c "echo > /root/.ssh/known_hosts"
# sudo bash -c "echo > /root/.ssh/authorized_keys"
sudo subscription-manager unregister
sudo subscription-manager clean

active-interfaces=( $(ls -1 /sys/class/net -I lo) )
printf '%s ' "${active-interfaces[*]}"

for ((i=0 ; i < ${#active-interfaces[@]}; i++))
    do
        sudo nmcli connection clone ${active-interfaces[$i]} Cloned${active-interfaces[$i]}
        sudo nmcli connection up Cloned${active-interfaces[$i]}
        sudo nmcli connection delete ${active-interfaces[$i]}
        sudo nmcli connection clone Cloned${active-interfaces[$i]} ${active-interfaces[$i]}
        sudo nmcli connection up ${active-interfaces[$i]}
        sudo nmcli connection delete Cloned${active-interfaces[$i]}
    done
EOF

# executable permissiions
sudo chmod 744 /usr/local/sbin/CloneVM-SSH.bash
# not part of the script if we want to save the existing keys
# echo > /root/.ssh/authorized_keys

#
sudo bash -c "cat > /usr/local/sbin/CloneNetwork.bash" <<-'EOF'
#!/usr/bin/env bash
active-interfaces=( $(ls -1 /sys/class/net -I lo) )
printf '%s ' "${active-interfaces[*]}"

for ((i=0 ; i < ${#active-interfaces[@]}; i++))
    do
        sudo nmcli connection clone ${active-interfaces[$i]} Cloned${active-interfaces[$i]}
        sudo nmcli connection up Cloned${active-interfaces[$i]}
        sudo nmcli connection delete ${active-interfaces[$i]}
        sudo nmcli connection clone Cloned${active-interfaces[$i]} ${active-interfaces[$i]}
        sudo nmcli connection up ${active-interfaces[$i]}
        sudo nmcli connection delete Cloned${active-interfaces[$i]}
    done
EOF

# executable permissiions
sudo chmod 744 /usr/local/sbin/CloneNetwork.bash
