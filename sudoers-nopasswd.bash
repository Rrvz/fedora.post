# sed -i '/NOPASSWD: ALL/a ricardo        ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers | grep NOPASSWD
# sed -i '/NOPASSWD: ALL/a x              ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers | grep NOPASSWD
# sed -i '/NOPASSWD: ALL/a dorro2         ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers | grep NOPASSWD
#


echo "
## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL

## Same thing without a password
ricardo         ALL=(ALL)       NOPASSWD: ALL
x               ALL=(ALL)       NOPASSWD: ALL
" > ./local-sudoers
sudo chown root:root ./local-sudoers
sudo mv ./local-sudoers /etc/sudoers.d/
