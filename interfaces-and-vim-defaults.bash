
sudo bash -c "cat >> /etc/vimrc" <<-'EOF'

""#To avoid pasting commented on all lines when you have one commented line

""On pressing tab, insert 4 spaces
set expandtab
""tab is equal to 4 and autoindent is mark with >
filetype plugin indent on
""show existing tab with 4 spaces width
set tabstop=4
""when indenting with '>', use 4 spaces width
set shiftwidth=4
""set  paste disable autoindent in vim
set pastetoggle=<F2>

"#Poweline module for Vim
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set  rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/
set t_Co=256


EOF

#create services for Array Interfaces

sudo bash -c "cat > /etc/systemd/system/ArrayInterfaces.service" <<-'EOF'
[Unit]
After=default.target

[Service]
ExecStart=/usr/local/sbin/ArrayInterfaces.bash

[Install]
WantedBy=default.target
EOF

sudo chmod 644 /etc/systemd/system/ArrayInterfaces.service
sudo systemctl daemon-reload
sudo systemctl enable ArrayInterfaces.service

sudo bash -c "cat > /etc/systemd/system/MonitorNet.service" <<-'EOF'
[Unit]
After=After=default.target ArrayInterfaces.service

[Service]
ExecStart=/usr/local/sbin/MonitorNet.bash

[Install]
WantedBy=default.target


EOF

sudo chmod 644 /etc/systemd/system/MonitorNet.service
sudo systemctl daemon-reload
sudo systemctl enable MonitorNet.service

#
#Creation of bash script for Interfaces
#

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
    sudo bash -c "ls /sys/class/net/ > /tmp/watchfile2"
    sudo diff -q /tmp/watchfile /tmp/watchfile2 > /dev/null
    if [ $? -ne 0 ] ; then
    sudo echo "File list changed"
    sudo /bin/bash /usr/local/sbin/ArrayInterfaces.bash
    fi
    sudo /bin/cp -r /tmp/watchfile2 /tmp/watchfile
done
EOF


sed -i '/NOPASSWD: ALL/a dorro2        ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers | grep NOPASSWD
sed -i '/NOPASSWD: ALL/a x        ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers | grep NOPASSWD

#bash permissions

sudo chmod 744 /usr/local/sbin/ArrayInterfaces.bash
sudo systemctl start ArrayInterfaces.service

sudo chmod 744 /usr/local/sbin/MonitorNet.bash
sudo systemctl start MonitorNet.service


#Change ssh_host keys

sudo bash -c "cat > /usr/local/sbin/CloneVMSSH.bash" <<-"EOF"
#!/bin/bash
sudo /bin/rm -fr /etc/ssh/ssh_host_*
sudo systemctl restart sshd
#    sudo rm -rf /root/.ssh/id_rsa
#    sudo rm -rf /root/.ssh/id_rsa.pub
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

#ec
sudo chmod 744 /usr/local/sbin/CloneVMSSH.bash
#not part of the script if we want to save the existing keys
#echo > /root/.ssh/authorized_keys

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

#ec
sudo chmod 744 /usr/local/sbin/CloneNetwork.bash

exit 0
#End of sctipt
