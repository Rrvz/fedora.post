
lpstat -t
lpstat -p
lpstat -a

# do a function to check if printer despacho or other printer is idlde pause or
# disabled

# enable printer

Printers_x00=`lpstat -p | grep "disabled" | awk '{print $2}'`
sudo lprm $Printers_x00
sudo cupsenable $Printers_x00; lpstat -p
# sudo cupsdisable $Printers_x00; lpstat -p



# enable printer
sudo cupsenable Ricoh_MP_3054_01; lpstat -p
# disable printer
sudo cupsdisable Ricoh_MP_3054_01; lpstat -p
sudo cupsdisable RICOH_MP_3054_ipv4; lpstat -p

# reject jobs for printer
sudo cupsreject Ricoh_MP_3054_01; lpstat -p
# accept jobs for printer
sudo cupsaccept Ricoh_MP_3054_01; lpstat -p

# kill the current job stopping the printer
sudo lprm Ricoh_MP_3054_01

# kill al jobs
sudo cancel -a -x

# show jobs
lpstat -o


# script 00
# enable disable printer
# lpstat -p

sudo bash -c "cat > /usr/local/sbin/cupsmonitor.bash" <<-'EOF'
#!/bin/env bash
#
# Check if a printer queue is disabled and reenable it.

File_x00=test
String_x00=disabled
Command_x00="lpstat -p"

if [[ $($Command_x00 | grep "$String_x00") ]]; then
    Printers_x00=`lpstat -p | grep "disabled" | awk '{print $2}'`
    sudo lprm $Printers_x00
    sudo cupsenable $Printers_x00; lpstat -p
else
    :
fi
EOF

sudo bash -c "cat > /etc/systemd/system/cupsmonitor.service" <<-'EOF'
[Unit]
Description=Monitor Cups disabled printers
Requires=cups.service

[Service]
ExecStart=/bin/bash /usr/local/sbin/cupsmonitor.bash
EOF

sudo bash -c "cat > /etc/systemd/system/cupsmonitor.timer" <<-'EOF'
[Unit]
Description=Timer Monitor Cups disabled printers

[Timer]
OnActiveSec=60s
OnUnitActiveSec=60s
Unit=cupsmonitor.service

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable cupsmonitor.service
sudo systemctl start cupsmonitor.service

sudo systemctl enable cupsmonitor.timer
sudo systemctl start cupsmonitor.timer



# script to monitor pending jobs


Printers_x01=`lpstat -p | grep "disabled" | awk '{print $2}'`
sudo lprm $Printers_x01
sudo cupsenable $Printers_x01; lpstat -p

sudo lprm Printers_x01


sudo chmod 744 /usr/local/sbin/cupsmonitor.bash
# sudo chmod 744 /etc/systemd/system/cupsmonitor.service
# monitoring services
sudo journalctl -f -u cupsmonitor.service
sudo journalctl -f -u cupsmonitor.timer
