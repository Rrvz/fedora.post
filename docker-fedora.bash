#!/usr/bin/env bash
sudo dnf remove docker -y \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# 1. Install the dnf-plugins-core package which provides the commands to manage your DNF repositories from the command line.
sudo dnf -y install dnf-plugins-core

# 2.
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo


# enable edge and test optional
# sudo dnf config-manager --set-enabled docker-ce-edge
# sudo dnf config-manager --set-enabled docker-ce-test
# sudo dnf config-manager --set-enabled docker-ce-nightly

# disable edge and test
# sudo dnf config-manager --set-disabled docker-ce-edge

# sudo dnf install -y docker-ce
# update Wed 29 May 2019 11:54:36 PM AST
# sudo dnf install docker-ce docker-ce-cli containerd.io


# if error not sync because fedora 29, 30 or newewr OS packages are not avaiblabe install the
# enable test o nightly version
# sudo dnf config-manager --set-enabled docker-ce-test
# sudo dnf config-manager --set-disabled docker-ce-stable
# sudo dnf install docker-ce docker-ce-cli containerd.io
sudo dnf install -y --releasever=29 docker-ce docker-ce-cli containerd.io
# then
# sudo dnf install -y docker-ce

# sudo systemctl start docker
# sudo systemctl status docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl status docker -l -l --no-pager

sudo bash -c "cat > /etc/docker/daemon.json" <<-"EOF"
{
    "bip": "172.17.0.1/20",
    "fixed-cidr": "172.17.0.0/20",
    "ipv6": true,
    "fixed-cidr-v6": "fc00:dead:beef::/64"
}
EOF

# if error
sudo dockerd

sudo systemctl restart docker && sudo systemctl status docker -l --no-pager


# or
# curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
# sudo usermod -aG docker $USER
