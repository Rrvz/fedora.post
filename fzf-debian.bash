# cat /usr/share/doc/fzf/README.Debian

sudo apt-get updatei

apt-get install wget -y
wget http://ftp.br.debian.org/debian/pool/main/f/fzf/fzf_0.18.0-2_amd64.deb
dpkg -i fzf_0.18.0-2_amd64.deb
echo source /usr/share/doc/fzf/examples/key-bindings.bash > ~/.bashrc
source ~/.bashrc





apt-get update; apt-get install vim git wget -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
source ~/.bashrc

