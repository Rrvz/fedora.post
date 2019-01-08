
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

sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

# enable edge and test optional
# sudo dnf config-manager --set-enabled docker-ce-edge
# sudo dnf config-manager --set-enabled docker-ce-test
# disable edge and test
# sudo dnf config-manager --set-disabled docker-ce-edge

sudo dnf install -y docker-ce

sudo systemctl start docker
sudo systemctl sstatus docker
sudo systemctl enable docker

sudo usermod -aG docker $USER


# or

curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
sudo usermod -aG docker $USER



