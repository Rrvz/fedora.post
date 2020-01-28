#!/usr/bin/env bash
# run as administrator or root

echo "
## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL

## Same thing without a password
ricardo         ALL=(ALL)       NOPASSWD: ALL
x               ALL=(ALL)       NOPASSWD: ALL
" > ./local-sudoers
sudo chown root:root ./local-sudoers
sudo mv ./local-sudoers /etc/sudoers.d/

# disable dns internal resolver fedora
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved.service

# update to all system
sudo dnf update -y

# Fix dnf problem unable to install because a : No match for argument:
# gir1.2-clutter, error: Unable to find a match

File_X0="/etc/dnf/dnf.conf"
String_X0="strict=True"
String_X1="strict=False"
if [ ! -z $(grep "$String_X0" "$File_X0") ]; then
    if [ ! -z $(grep "$String_X1" "$File_X0") ]; then
        echo "$String_X1 value is already in file"
    else
        sudo sed -i "/$String_X0/c $String_X1" $File_X0
    fi
else
sudo bash -c "echo "$String_X1" >> /etc/dnf/dnf.conf"
echo "$String_X1 value added to $File_X0"
fi

# dnf or yum
sudo dnf install dnf-utils -y
# sudo yum install dnf-utils -y

# add RPM-Fusion to system-wide
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install main packages
sudo dnf install -y kernel-devel kernel-headers gcc dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
sudo dnf install -y radvd tcpdump git diffutils colordiff

# Install xauth for ssh gui mode
sudo dnf install -y xauth

# Normal installation developer packages
sudo dnf install -y cmake gcc-c++ make python3-devel ncurses-compat-libs
sudo dnf install -y automake cmake gcc gcc-c++ kernel-devel cmake python-devel python3-devel

# Install desktop environment
# sudo dnf install -y switchdesk switchdesk-gui
# sudo dnf install -y @kde-desktop-environment
# sudo dnf install -y @mate-desktop-environment

# Codecs
# sudo dnf -y install ffmpeg2theora ffmpeg mencoder
# sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

# Compression utilities
sudo dnf -y install unrar p7zip p7zip-plugins tar

# Imagenes las mejores :)
# sudo dnf -y install converseen gimp

# text editor
# sudo dnf -y install atom
# Recorder, player, and downloader
# sudo dnf install -y vlc shutter youtube-dl

#Update pip to work wi th latest stable python version
sudo dnf install python3-pip
#which pip3
sudo python3 -m pip install -U pip

# sudo pip install --upgrade python
sudo pip install pathlib2 lxml requests-ftp wrapt
sudo pip install --upgrade pip

# Task Warrior and
# sudo dnf install -y task bugwarrior python3-taskw python2-taskw

#Command-line fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

sudo dnf install -y the_silver_searcher ripgrep

# shell extensions
# sudo dnf install -y chrome-gnome-shell #nome-shell-extension-dash-to-dock gir1.2-clutter

# drivers
# sudo su
# sudo bach -c "echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf"
# sudo dracut /boot/initramfs-$(uname -r).img $(uname -r) --force

# dnf install xorg-x11-drv-nouveau

# install vim 8.4
sudo dnf install -y vim vim-X11 xclip xsel

sudo dnf install -y vim open-vm-tools sos wget mlocate net-tools which man htop wget curl lynx traceroute jwhois htop telnet openssh perl ftp deltarpm colorize bash-completion bind-utils ldns ldns-utils chrony rng-tools subnetcalc ipv6calc ipcalc gcc lshw setools-console inotify-tools tcpdump wireshark dstat sysstat ansible psmisc tree sshpass
sudo dnf install -y nload iftop iptraf nethogs bmon bwm-ng nmap iperf iperf3
sudo dnf groupinstall -y "Development Tools" && sudo yum install cmake -y
sudo dnf install -y python-pip python2-pip python3-pip git
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
sudo yum update -y


# add localuser as part of the group
sudo usermod -a -G wireshark $USER

# install fontforge
# sudo dnf install fontforge;

# Installing Pipenv on Fedora
sudo dnf install -y pipenv
# sudo dnf install -y thonny

sudo dnf install -y rubygems

if [[ $(gem list -i lolcat| grep 'true') ]]; then
    # echo "locat is already installed"
    :
else
    gem install lolcat
fi

ls -ls | lolcat

sudo dnf install tmux -y

# Chafa command line image converter and viewer
# sudo dnf install -y autoconf automake libtool gtk-doc glib2-devel ImageMagick-devel
# git clone https://github.com/hpjansson/chafa
# cd chafa
# ./autogen.sh
# make
# sudo make install

# vtop from Node JS
sudo dnf install -y npm

if [[ $(npm list -g vtop | grep "vtop") ]]; then
    echo "vtop is already installed"
else
    sudo npm install -g vtop
fi


# build rpm packages
sudo dnf install -y rpmdevtools gcc make imlib2-devel libjpeg-devel \
libpng-devel libXt-devel libXinerama-devel libexif-devel  perl-Test-Command \
perl-Test-Harness libcurl-devel



# Powerline for fedora install
# sudo dnf install -y powerline
#
# File_X3="$HOME/.bashrc"
# String_X3="POWERLINE_BASH_CONTINUATION"
#
# if [ ! -z $(grep "$String_X3" "$File_X3" ) ]; then
#     # echo "String_X3 value is already in file"
#     :
# else
#     echo "
# # Source for powerline
# if [ -f `which powerline-daemon` ]; then
#   powerline-daemon -q
#   POWERLINE_BASH_CONTINUATION=1
#   POWERLINE_BASH_SELECT=1
#   # . /usr/share/powerline/bash/powerline.sh
#   . ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
# fi
# " >> $File_X3
# fi
#
# aliases for vimx support clipboard

File_X3="$HOME/.bashrc"
String_X3="alias vi='vimx'"
String_X4="alias vim='vimx'"

if [[ ! -z $(grep "$String_X3" "$File_X3" ) ]]; then
    :
else
    echo "
# Aliases for vimx or vim-X11
# Aliases for ssh copy / paste with X11 and vim clipboard support
if [ -f `which vimx` ]; then
alias vi='vimx'
alias vim='vimx'
alias ssh='ssh -Y'
fi
" >> $File_X3
fi

# # load git json module
# # mkdir -p ~/.config/powerline
# # cat <<-'EOF' > ~/.config/powerline/config.json
# # {
# #     "ext": {
# #         "shell": {
# #             "theme": "default_leftonly"
# #         }
# #     }
# # }
# # EOF
#
# powerline-daemon --replace
#

