#!/bin/bash

#libs to install
sudo yum install gcc kernel-devel make ncurses-devel libevent libevent-devel -y
# yum install tmux -y

cd
sudo git clone https://github.com/tmux/tmux.git
cd tmux
sudo sh autogen.sh
sudo ./configure
#./configure --prefix=/usr/local
sudo make
sudo make install
cd
sudo rm tmux -rf

#
cd
#git clone https://github.com/gpakosz/.tmux.git
#ln -s -f .tmux/.tmux.conf
#cp .tmux/.tmux.conf.local .

#Search for and comment regular glyphs and uncomment powerline fonts

# status left/right sections separators
cd
#vim .tmux.conf.local

