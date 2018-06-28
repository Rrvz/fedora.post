sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y switchdesk switchdesk-gui

sudo dnf install -y @kde-desktop-environment

sudo dnf install -y @mate-desktop-environment

sudo dnf install -y kernel-devel kernel-headers gcc dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig


sudo dnf -y install gstreamer-plugins-base gstreamer1-plugins-base gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer1-plugins-ugly gstreamer-plugins-good-extras gstreamer1-plugins-good-extras gstreamer1-plugins-bad-freeworld ffmpeg gstreamer-ffmpeg

#codecs
sudo dnf -y install ffmpeg2theora ffmpeg mencoder
sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

#
dnf -y install unrar p7zip p7zip-plugins

#imagenes
sudo dnf -y install converseen gimp 

#text editor
sudo dnf -y install atom 

sudo dnf install -y vlc shutter youtube-dl 

#Update pip to work wi th latest stable python version 
sudo dnf install python3-pip
pip3
sudo python3 -m pip install -U pip

sudo pip install --upgrade python
sudo pip install pathlib2 lxml requests-ftp wrapt
sudo pip install --upgrade pip




#shell extensions
#udo dnf install -y chrome-gnome-shell gnome-shell-extension-dash-to-dock gir1.2-clutter

#drivers

sudo su

sudo bach -c "echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf"
sudo dracut /boot/initramfs-$(uname -r).img $(uname -r) --force

dnf install xorg-x11-drv-nouveau


