#!/usr/bin/env bash

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
#cd
#git clone https://github.com/gpakosz/.tmux.git
#ln -s -f .tmux/.tmux.conf
#cp .tmux/.tmux.conf.local .

#Search for and comment regular glyphs and uncomment powerline fonts

# status left/right sections separators
#cd
#vim .tmux.conf.local

# Set italics on in tmux
set -g default-terminal "tmux" # colors!

# https://github.com/tmux/tmux/issues/1246

# important！24 bit color
#set -g default-terminal "tmux-256color"
#set -ga terminal-overrides ",*256col*:Tc"
set -g default-terminal "tmux-256color"
# enable 24 bit support
set -g terminal-overrides ',xterm-256color:Tc'
