git clone https://github.com/vim/vim.git
cd vim/src
sudo make distclean
./configure --enable-gui=auto --enable-gtk2-check --with-x --prefix=/usr
sudo make
sudo make install

