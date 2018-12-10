#!/bin/bash
# sudo dnf clean all
sudo touch /etc/yum.repos.d/mongodb.repo
sudo bash -c "cat > /etc/yum.repos.d/mongodb.repo" <<-'F-EOF'
[Mongodb]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
F-EOF

sudo dnf remove -y mongodb-org
sudo dnf install -y mongodb-org

sudo systemctl enable mongod
sudo systemctl start mongod
sudo systemctl restart mongod
# sudo systemctl status mongod

sudo dnf install -y mongodb-org
sudo dnf install policycoreutils-python-utils -y
sudo semanage port -a -t mongod_port_t -p tcp 27017

# install compass GUI
wget https://downloads.mongodb.com/compass/mongodb-compass-1.15.1.x86_64.rpm;
sudo dnf install mongodb-compass-1.15.1.x86_64.rpm;
mongodb-compass;

# Remove Data Directories
# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongo


sudo vim /etc/mongod.conf

# network interfaces
net:
  ipv6: true
  port: 27017
  bindIp: ::1,127.0.0.1 # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.

