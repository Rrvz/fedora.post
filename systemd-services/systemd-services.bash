# create a bash script and copy it in /usr/bin/
vmware-promiscuous-vmnet.bash
# gave it execution permissions
sudo bash -c "cat > /usr/bin/vmware-promiscuous-vmnet.bash" <<-'EOF'
sudo chgrp $GROUPS /dev/vmnet*
sudo chmod g+rw /dev/vmnet*
sudo chmod a+rw /dev/vmnet*
EOF

sudo chmod 755 /usr/bin/vmware-promiscuous-vmnet.bash

sudo bash -c "cat > /usr/lib/systemd/system/vmware-promiscuous.service" <<-'EOF'
[Unit]
Description=VMware vmnet promiscuous mode
Requires=network.target

[Service]
Type=idle
ExecStart=/usr/bin/bash /usr/bin/vmware-promiscuous-vmnet.bash

[Install]
WantedBy=multi-user.target
EOF

sudo ln -s /usr/lib/systemd/system/vmware-promiscuous.service /etc/systemd/system/vmware-promiscuous.service

sudo systemctl daemon-reload
sudo systemctl enable vmware-promiscuous.service
sudo systemctl start vmware-promiscuous.service
sudo systemctl status vmware-promiscuous.service
