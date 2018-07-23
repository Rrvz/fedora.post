#!/usr/bin/env bash

#Fix dnf problem unable to install because a : No match for argument:
#gir1.2-clutter, error: Unable to find a match

File_X0="/etc/dnf/dnf.conf"
String_X0="strict="
String_X1="strict=False"
if [ ! -z $(grep "$String_X0" "$File_X0") ]; then
    if [ ! -z $(grep "$String_X1" "$File_X0") ]; then
        echo "$String_X1 value is already in file"
    else
        sudo sed -i "/$String_X0/c $String_X1" $File_X0
    fi
else
sudo bash -c "echo "$String_X0" >> /etc/dnf/dnf.conf"
echo "$String_X1 value added to $File_X0"
fi

#add RPM-Fusion to system-wide
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#install main packages
sudo dnf install -y kernel-devel kernel-headers gcc dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig

sudo dnf -y install gstreamer-plugins-base gstreamer1-plugins-base gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer1-plugins-ugly gstreamer-plugins-good-extras gstreamer1-plugins-good-extras gstreamer1-plugins-bad-freeworld ffmpeg gstreamer-ffmpeg

#install desktop environment
sudo dnf install -y switchdesk switchdesk-gui
#sudo dnf install -y @kde-desktop-environment
#sudo dnf install -y @mate-desktop-environment

#codecs
sudo dnf -y install ffmpeg2theora ffmpeg mencoder
sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

# Compression utilities
sudo dnf -y install unrar p7zip p7zip-plugins tar

#imagenes las mejores :)
sudo dnf -y install converseen gimp

#text editor
sudo dnf -y install atom
#Recorder, player, and downloader
sudo dnf install -y vlc shutter youtube-dl

#Update pip to work wi th latest stable python version
sudo dnf install python3-pip
#which pip3
sudo python3 -m pip install -U pip

sudo pip install --upgrade python
sudo pip install pathlib2 lxml requests-ftp wrapt
sudo pip install --upgrade pip

# Task Warrior and
sudo dnf install -y task bugwarrior python3-taskw python2-taskw

#Command-line fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

dnf install the_silver_searcher

#shell extensions
sudo dnf install -y chrome-gnome-shell #nome-shell-extension-dash-to-dock gir1.2-clutter

#drivers

#sudo su

#sudo bach -c "echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf"
#sudo dracut /boot/initramfs-$(uname -r).img $(uname -r) --force

#dnf install xorg-x11-drv-nouveau

sudo dnf install -y vim open-vm-tools sos wget mlocate net-tools which man htop wget curl lynx traceroute jwhois htop telnet openssh perl ftp deltarpm colorize bash-completion bind-utils ldns ldns-utils chrony rng-tools subnetcalc ipv6calc ipcalc gcc lshw setools-console inotify-tools tcpdump wireshark dstat sysstat ansible psmisc tree
sudo dnf install -y nload iftop iptraf nethogs bmon bwm-ng nmap iperf iperf3
sudo dnf groupinstall -y "Development Tools" && sudo yum install cmake -y
sudo dnf install -y python-pip python2-pip python3-pip git
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
sudo yum update -y


# install fontforge
sudo dnf install fontforge;


sudo dnf install pipenv
