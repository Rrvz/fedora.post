#!/usr/bin/env bash
# create services for Array Interfaces

sudo bash -c "cat > /usr/lib/systemd/system/ArrayInterfaces.service" <<-'EOF'
[Unit]
Description=Array of interfaces
After=network.target

[Service]
Type=idle
ExecStart=/usr/bin/bash /usr/local/sbin/ArrayInterfaces.bash

[Install]
WantedBy=default.target
EOF

sudo bash -c "cat > /etc/systemd/system/MonitorNet.service" <<-'EOF'
[Unit]
Description=Monitor interfaces
After=default.target ArrayInterfaces.service

[Service]
ExecStart=/usr/bin/bash /usr/local/sbin/MonitorNet.bash

[Install]
WantedBy=default.target
EOF

# Creation of bash script for Interfaces

sudo bash -c "cat > /usr/local/sbin/ArrayInterfaces.bash" <<-'EOF'
#!/bin/bash
ArrayInterfaces=( $(ls -1 /sys/class/net -I lo) )
    ArrayIPv6=( $(printf "\\\6{%s} - " "${ArrayInterfaces[@]}") )
    unset 'ArrayIPv6[${#ArrayIPv6[@]}-1]'
    ArrayIPv4=( $(printf "\\\4{%s} - " "${ArrayInterfaces[@]}") )
    unset 'ArrayIPv4[${#ArrayIPv4[@]}-1]'

echo "\S \l
Kernel \r on an \m

IPv6: "${ArrayIPv6[@]}"
IPv4: "${ArrayIPv4[@]}"
" > /etc/issue
EOF

sudo bash -c "cat > /usr/local/sbin/MonitorNet.bash" <<-'EOF'
#!/bin/bash
sudo bash -c "ls /sys/class/net/ > /tmp/watchfile"

while true; do
    sudo sleep 60
    sudo bash -c "ls /sys/class/net/ > /tmp/watchfile2
    sudo diff -q /tmp/watchfile /tmp/watchfile2 > /dev/null
    if [ $? -ne 0 ] ; then
    sudo echo "File list changed"
    sudo /bin/bash /usr/local/sbin/ArrayInterfaces.bash
    fi
    sudo /bin/cp -r /tmp/watchfile2 /tmp/watchfile
done
EOF

#bash permissions

# sudo chmod 755 /usr/lib/systemd/system/ArrayInterfaces.service
sudo chmod 744 /usr/local/sbin/ArrayInterfaces.bash
sudo systemctl daemon-reload
sudo systemctl enable ArrayInterfaces.service
sudo systemctl start ArrayInterfaces.service
sudo systemctl status ArrayInterfaces.service

# sudo chmod 644 /etc/systemd/system/MonitorNet.service
sudo chmod 744 /usr/local/sbin/MonitorNet.bash
sudo systemctl daemon-reload
sudo systemctl enable MonitorNet.service
sudo systemctl start MonitorNet.service
sudo systemctl status MonitorNet.service


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

ArrayInterfaces=( $(ls -1 /sys/class/net -I lo) )
printf '%s ' "${ArrayInterfaces[*]}"

for ((i=0 ; i < ${#ArrayInterfaces[@]}; i++))
    do
        sudo nmcli connection clone ${ArrayInterfaces[$i]} Cloned${ArrayInterfaces[$i]}
        sudo nmcli connection up Cloned${ArrayInterfaces[$i]}
        sudo nmcli connection delete ${ArrayInterfaces[$i]}
        sudo nmcli connection clone Cloned${ArrayInterfaces[$i]} ${ArrayInterfaces[$i]}
        sudo nmcli connection up ${ArrayInterfaces[$i]}
        sudo nmcli connection delete Cloned${ArrayInterfaces[$i]}
    done
EOF

# executable permissiions
sudo chmod 744 /usr/local/sbin/CloneVM-SSH.bash
# not part of the script if we want to save the existing keys
# echo > /root/.ssh/authorized_keys

#
sudo bash -c "cat > /usr/local/sbin/CloneNetwork.bash" <<-'EOF'
#!/bin/bash
ArrayInterfaces=( $(ls -1 /sys/class/net -I lo) )
printf '%s ' "${ArrayInterfaces[*]}"

for ((i=0 ; i < ${#ArrayInterfaces[@]}; i++))
    do
        sudo nmcli connection clone ${ArrayInterfaces[$i]} Cloned${ArrayInterfaces[$i]}
        sudo nmcli connection up Cloned${ArrayInterfaces[$i]}
        sudo nmcli connection delete ${ArrayInterfaces[$i]}
        sudo nmcli connection clone Cloned${ArrayInterfaces[$i]} ${ArrayInterfaces[$i]}
        sudo nmcli connection up ${ArrayInterfaces[$i]}
        sudo nmcli connection delete Cloned${ArrayInterfaces[$i]}
    done
EOF

# executable permissiions
sudo chmod 744 /usr/local/sbin/CloneNetwork.bash
