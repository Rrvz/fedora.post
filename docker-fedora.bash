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
sudo dnf install -y docker-ce docker-ce-cli containerd.io


# if error not sync because fedora 29, 30 or newewr OS packages are not avaiblabe install the
# enable test o nightly version
# sudo dnf config-manager --set-enabled docker-ce-test
# sudo dnf config-manager --set-disabled docker-ce-stable
# sudo dnf install docker-ce docker-ce-cli containerd.io
# sudo dnf install -y --releasever=29 docker-ce docker-ce-cli containerd.io
# then
# sudo dnf install -y docker-ce

# install docker-compose from OS<F5>
sudo dnf install docker-compose -y

# install docker-compose from pip
# sudo pip install docker-compose

# install docker-compose from
# sudo curl -L --fail https://github.com/docker/compose/releases/download/1.24.0/run.sh -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose


# sudo systemctl start docker
# sudo systemctl status docker
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

sudo systemctl enable docker
sudo usermod -aG docker $USER

# if error
# sudo dockerd

sudo systemctl restart docker && sudo systemctl status docker -l --no-pager
echo "run as sudo:

sudo usermod -aG docker $USER"

sudo usermod -aG docker $USER
# or
# curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
# sudo usermod -aG docker $USER


# if error cgroup

sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# working
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=0"

sudo grub2-mkconfig
