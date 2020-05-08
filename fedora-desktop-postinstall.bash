#!/usr/bin/env bash

# Add to file in sudoers directory
sudo bash -c "cat > /etc/sudoers.d/users" <<-'EOF'
%wheel  ALL=(ALL)   NOPASSWD: ALL
EOF

#Fix dnf problem unable to install because a : No match for argument:
#gir1.2-clutter, error: Unable to find a match
File0="/etc/dnf/dnf.conf"
Str0="strict="
Str1="strict=False"
if [ ! -z $(grep "$Str0" "$File0") ]; then
    if [ ! -z $(grep "$Str1" "$File0") ]; then
        echo "$Str1 value is already in file"
    else
        sudo sed -i "/$Str0/c $Str1" $File0
    fi
else
sudo bash -c "echo "$Str0" >> /etc/dnf/dnf.conf"
echo "$Str1 value added to $File0"
fi

# add RPM-Fusion to system-wide
sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# update to all system
sudo dnf update -y

sudo dnf install dnf-utils -y

# install main packages
sudo dnf install -y kernel-devel kernel-headers gcc dkms acpid libglvnd-glx \
    libglvnd-opengl libglvnd-devel pkgconfig

# codes
sudo dnf -y install gstreamer-plugins-base gstreamer1-plugins-base \
    gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer1-plugins-ugly \
    gstreamer-plugins-good-extras gstreamer1-plugins-good-extras \
    gstreamer1-plugins-bad-freeworld ffmpeg gstreamer-ffmpeg

# codecs
sudo dnf -y install ffmpeg2theora ffmpeg mencoder
sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

# install for ipv6 radvd git and other
sudo dnf install -y radvd tcpdump git gitk diff colordiff asciinema


# Compression utilities
sudo dnf -y install unrar p7zip p7zip-plugins tar

# imagenes las mejores :)
sudo dnf -y install converseen gimp

# install vim 8.4
sudo dnf install -y vim vim-X11 xclip xsel

# text editor
sudo dnf -y install \
atom \
https://az764295.vo.msecnd.net/stable/d69a79b73808559a91206d73d7717ff5f798f23c/code-1.45.0-1588868440.el7.x86_64.rpm

# Recorder, player, and downloader
sudo dnf install -y vlc shutter youtube-dl

# Developers packages and cmake to power your compile time ;)
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y cmake gcc-c++ make python3-devel ncurses-compat-libs \
    automake cmake gcc gcc-c++ kernel-devel cmake python-devel python3-devel

# install NodeJS and yarn
sudo dnf install nodejs npm -y
sudo npm install -g yarn

# core packages
sudo dnf install -y \
    open-vm-tools sos wget mlocate net-tools which man htop wget curl lynx \
    traceroute jwhois htop telnet openssh perl ftp deltarpm colorize \
    bash-completion bind-utils ldns ldns-utils chrony rng-tools subnetcalc \
    ipv6calc ipcalc gcc lshw setools-console inotify-tools tcpdump wireshark \
    dstat sysstat ansible psmisc tree

sudo dnf install -y nload iftop iptraf nethogs bmon bwm-ng nmap iperf iperf3

# Installing Pipenv on Fedora
sudo dnf install -y pipenv

sudo dnf install -y rubygems
# gem install lolcat
# ls -ls | lolcat

# vtop from Node JS
sudo npm install -g vtop

# Restore ssh keys
# ssh-add -l
# chmod 600 ~/.ssh/*
# chmod 644 ~/.ssh/*.pub

# setup zsh
sudo dnf install -y util-linux-user zsh
# install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fix plain URl without quotes not working in zsh due magic functions
File0="$HOME/.zshrc"
Str0='export ZSH='
Str1='DISABLE_MAGIC_FUNCTIONS=true'
sed -i "/$Str0/i $Str1" $File0

# History size for zsh and bash
File0="$HOME/.oh-my-zsh/lib/history.zsh"
MsgStr0='File not found'
Str0='HISTSIZE='
Str1='HISTSIZE=9000000'
Str2='SAVEHIST='
Str3='SAVEHIST=8000000'

[ -f "$File0" ] && sed -i "/$Str0/c"$Str1"" $File0 || echo "$MsgStr0"
[ -f "$File0" ] && sed -i "/$Str2/c"$Str3"" $File0 || echo "$MsgStr0"

# Command-line fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc
source ~/.zshrc

# Advance searchers
sudo dnf install the_silver_searcher ripgrep fd-find -y

# Powerline fonts
# clone
# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# clean-up a bit
# cd ..
# rm -rf fonts

# nerdfonts local install
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf

curl -fLo "DejaVu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

# Setup enpass (password manager)
cd /etc/yum.repos.d/
[ ! -f enpass-yum.repo ] && sudo wget https://yum.enpass.io/enpass-yum.repo
sudo dnf install -y enpass

# web brosers and mail
sudo dnf install -y firefox thunderbird

# install tilix
sudo dnf install -y tilix tilix-nautilus

# Fix tilix issue VTE Configuration

#File0='~/.zshrc'
#[ -f "$File0" ] && sudo bash -c "cat >> .zshrv" <<-'EOF'

#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi

# install ext app and search through the web and update to post-install
sudo dnf install -y gnome-extensions-app

# mod tilix and use dark theme, copy on click, fonts to dejavu or
# hack nerdfonts, #10, themes for dark cli.
# tilix keyboard shortcut 'control + alt + t'
# mode for scroll size to 110111

#curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -


# missing zshrc

# Git setup after add keys
git config --global user.email "mymail@mydomain.com"
git config --global user.name "Ricardo Rodriguez"







# ---------------------------------------------------------------------------

# disabled

# No longer need it for the operative system

# ---------------------------------------------------------------------------

# install desktop environment
# sudo dnf install -y switchdesk switchdesk-gui
#sudo dnf install -y @kde-desktop-environment
#sudo dnf install -y @mate-desktop-environment

# Update pip to work wi th latest stable python version
# sudo dnf install python3-pip
# which pip3
# sudo python3 -m pip install -U pip

# sudo pip install --upgrade python
# sudo pip install pathlib2 lxml requests-ftp wrapt
# sudo pip install --upgrade pip


#sudo su

#sudo bach -c "echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf"
#sudo dracut /boot/initramfs-$(uname -r).img $(uname -r) --force

#dnf install xorg-x11-drv-nouveau


# sudo dnf install -y python-pip python2-pip python3-pip git
# sudo pip install --upgrade pip
# sudo pip3 install --upgrade pip

# install fontforge
# sudo dnf install fontforge;

# Chafa command line image converter and viewer
# sudo dnf install -y autoconf automake libtool gtk-doc glib2-devel ImageMagick-devel
# git clone https://github.com/hpjansson/chafa
# cd chafa
# ./autogen.sh
# make
# sudo make install

# Task Warrior and
# sudo dnf install -y task bugwarrior python3-taskw python2-taskw

# add aliases to bashrc
# File_X3="$HOME/.bashrc"
# String_X3="alias vi='vimx'"
# String_X4="alias vim='vimx'"
#
# if [[ ! -z $(grep "$String_X3" "$File_X3" ) ]]; then
#     :
# else
#     echo "
# # Aliases for vimx or vim-X11
# # Aliases for ssh copy / paste with X11 and vim clipboard support
# if [ -f `which vimx` ]; then
# alias vi='vimx'
# alias vim='vimx'
# alias ssh='ssh -Y'
# fi
# " >> $File_X3
# fi
