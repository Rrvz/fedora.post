sudo dnf install ansible -y
# sudo yum install ansible -y

ansible --version
# new Twisted Edwards curve algorithm
ssh-keygen -t ed25519 -C "ssh key ricardo@ryzen"
# specific file
ssh-keygen -t ed25519 -f ~/.ssh/id_mine -C "key x@ryzen"
ssh-keygen -t ed25519 -f ~/.ssh/id_r -C "key x@ryzen"
# with passphrase
ssh-keygen -t ed25519 -f ~/.ssh/id_passphrase -C "key passphrase x@ryzen"
# old keys
# ssh-keygen -t rsa -b 4096 -f ~/.ssh/vps-cloud.web-server.key -C "My web-server key"


ssh-copy-id -i $HOME/.ssh/id_r.pub root@server1.domain.com
ssh-copy-id -i $HOME/.ssh/id_r.pub root@192.168.220.199
ssh-copy-id -i $HOME/.ssh/id_passphrase.pub root@192.168.220.199
# force copy if exists
ssh-copy-id -i $HOME/.ssh/id_passphrase.pub root@192.168.220.199

# add passphrase to ssh-add to never get ask again
ssh-add .ssh/id_passphrase
# List every passphare saved
ssh-add -l
# Delete all stored passphases
ssh-add -D
