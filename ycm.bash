# ImportError: libtinfo.so.5: cannot open shared object file
# sudo dnf install -y ncurses-compat-libs

# Normal installation developer suff
sudo dnf install cmake gcc-c++ make python3-devel ncurses-compat-libs

sudo dnf install -y automake cmake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
sudo dnf install -y mono-devel golang rust cargo

# Fix error with rpm not running as sudo
# sudo curl -sL https://rpm.nodesource.com/setup_10.x | bash -
wget https://rpm.nodesource.com/setup_10.x
sed -i 's/rpm -i --nosignature/sudo rpm -i --nosignature/g' setup_10.x
# sed -i 's/"rm -f/"sudo rm -f/g' setup_10.x
bash setup_10.x
rm -rf setup_10.x
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo dnf install -y gcc-c++ make nodejs #npm
sudo dnf -y install yarn

# install This as root or report error to JavaScript usign yarn
sudo yarn global add npm@latest
sudo yarn global add typescript

# install as root or report error to JavaScript usign NPM
# sudo npm install npm@latest -g
# sudo npm install -g typescript

# compile it
cd ~/.vim/plugged/YouCompleteMe/
git submodule update --init --recursive
./install.py --clangd-completer --cs-completer --go-completer --js-completer  --rust-completer
time python3 ./install.py --all
# ./install.py --all

# data
dnf config-manager --set-enable update mono-devel




