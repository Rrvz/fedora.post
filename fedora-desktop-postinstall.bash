#!/usr/bin/env bash

# Functions definition
_check_if_file_exits(){
    # messages
    # positional parameters
    local _file_0=$1
    # commands
    # [ -f "$_file_0" ] && `$_msg_0` || `$_msg_1`
    [ -f "$_file_0" ]
}

# _file_0='file.css'
# _check_if_file_exists $_file_0
# declare for sudo/root usage
# _Declare_0=`declare -f _check_if_file_exists

_check_if_file_writable(){
    # messages
    local _msg_0="File writable."
    local _msg_1="Error file not writable."
    # positional parameters
    local _file_0=$1
    # commands
    [ -w "$_file_0" ] && echo $_msg_0 || echo $_msg_1
}
# _file_0='file.css'
# _check_if_file_writable $_file_0

# function to check if string is in file.
_check_single_string_in_file() {
    # messages
    local _msg_0="String found."
    local _msg_1="String not found."
    # positional parameters
    local _str_0=$1
    local _file_0=$2
    # commands
    [[ -n $(grep "$_str_0" "$_file_0") ]] && echo $_msg_0 || echo $_msg_1
}
# _check_single_string_in_file best /etc/dnf/dnf.conf

# function to change string if exists in file.
# unset -f _change_single_string_all_occurences_lines _change_single_string_first_occurence_lines
_change_single_string_all_occurences_lines () {
    # messages
    local _msg_0="Error file not exits/writable or string nof found."
    # positional parameters
    local _str_0=$1
    local _str_1=$2
    local _file_0=$3
    # commands: check if file exists then, change the line if not append it.
    [[ -f "$_file_0" && -w "$_file_0" && -n $(grep "$_str_0" "$_file_0") ]] \
        && sed -i.bk --follow-symlinks "/$_str_0/c"$_str_1"" $_file_0 \
        || echo "$_msg_0"
}
_change_single_string_first_occurence_lines () {
    # messages
    local _msg_0="Error file not exits/writable or string nof found."
    # positional parameters
    local _str_0=$1
    local _str_1=$2
    local _file_0=$3
    # commands: check if file exists then, change the line if not append it.
    [[ -f "$_file_0" && -w "$_file_0" && -n $(grep "$_str_0" "$_file_0") ]] \
        && sed -i.bk --follow-symlinks "0,/$_str_0/c"$_str_1"" $_file_0 \
        || echo "$_msg_0"
}
#  export -f _change_string_in_file_f_w

_change_single_string_first_occurence () {
    # messages
    local _msg_0="Error file not exits/writable or string nof found."
    # positional parameters
    local _str_0=$1
    local _str_1=$2
    local _file_0=$3
    # commands: check if file exists then, change the line if not append it.
    [[ -f "$_file_0" && -w "$_file_0" && -n $(grep "$_str_0" "$_file_0") ]] \
        && sed -i.bk --follow-symlinks "s/$_str_0/$_str_1/1" $_file_0 \
        || echo "$_msg_0"
}

_change_string_if_exists_append_if_not () {
    # messages
    # local _msg_1="value added to $_file_0"
    local _msg_2="value is already in file"
    local _msg_0="Error file not exits/writable or string nof found."
    # positional parameters
    local _str_0=$1
    local _str_1=$2
    local _file_0=$3
    # commands: check if file exists then, change the line if not append it.
    [[ -f "$_file_0" && -w "$_file_0" && -n $(grep "$_str_0" "$_file_0") ]] \
        && { [[ -n `grep "$_str_1" "$_file_0"` ]] && echo "$_msg_2" \
            || sed -i.bk --follow-symlinks "/$_str_0/c"$_str_1"" $_file_0 ;} \
        || bash -c "echo "$_str_1" >> $_file_0"
}

# _file_0="/etc/dnf/dnf.conf"
# _str_0="strict="
# _str_1="strict=False"
# _change_string_if_exists_append_if_not $_str_0 $_str_1 $_file_0

# Function to check if is a specific user
# Function test if user root
_if_user_match_exit_0() {
    local _msg_0='Please must run as normal user or sime of the feature in
    this scrip will not work for the current user.'
    local _message_1="Running as a normal user for $USER"

    [[ "$EUID" = $1 ]] \
        && { echo $_msg_0 && exit ;} \
        || echo $_message_1
}
# invoke function to check for user root/EUID/ID=0
# _if_user_match_exit_0 '0'


# end of functions

# Script begins
# invoke function to check for user root/EUID/ID=0
_if_user_match_exit_0 '0'

# Add to file in sudoers directory
sudo bash -c "cat > /etc/sudoers.d/users" <<-'EOF'
%wheel  ALL=(ALL)   NOPASSWD: ALL
EOF

# change hostname
sudo hostnamectl set-hostname ryzen

#Fix dnf problem unable to install because a : No match for argument:
#gir1.2-clutter, error: Unable to find a match

# execute function to add string as normal user or sudo/root.
_file_0="/etc/dnf/dnf.conf"
_str_0="strict="
_str_1="strict=False"

_change_string_if_exists_append_if_not $_str_0 $_str_1 $_file_0 ||
_Declare_0=`declare -f _change_string_if_exists_append_if_not` &&
sudo bash -c "$_Declare_0; _change_string_if_exists_append_if_not $_str_0 $_str_1 $_file_0"

# old style
# _file_0="/etc/dnf/dnf.conf"
# _str_0="strict="
# _str_1="strict=False"
# if [ ! -z $(grep "$_str_0" "$_file_0") ]; then
#     if [ ! -z $(grep "$_str_1" "$_file_0") ]; then
#         echo "$_Str1 value is already in file"
#     else
#         sudo sed -i.bk --follow-symlinks "/$_str_0/c $_str_1" $_file_0
#     fi
# else
# sudo bash -c "echo "$_str_1" >> /etc/dnf/dnf.conf"
# echo "$_str_1 value added to $_file_0"
# fi
#
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

# install virtualization packages
sudo dnf group install -y --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# install stores: flatpak, snapd
# install flatpak
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak install flathub com.spotify.Client
# flatpak install flathub com.visualstudio.code

# install snapd
sudo dnf install -y snapd

# codes
sudo dnf -y install gstreamer-plugins-base gstreamer1-plugins-base \
    gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer1-plugins-ugly \
    gstreamer-plugins-good-extras gstreamer1-plugins-good-extras \
    gstreamer1-plugins-bad-freeworld ffmpeg gstreamer-ffmpeg

# more codecs
sudo dnf -y install ffmpeg2theora ffmpeg mencoder
sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

# install for ipv6 radvd git subversion
sudo dnf install -y radvd tcpdump

# istall swpan, send, expect and xdotool
sudo dnf install -y spawn expect xdotool

# install for git subversion
sudo dnf install -y git gitk colordiff diffutils subversion

# send mail from local
sudo dnf install -y mailx sendmail

# Compression utilities
sudo dnf -y install unrar p7zip p7zip-plugins tar

# imagenes las mejores :)
sudo dnf -y install converseen gimp

# Source code editors
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
#

sudo dnf -y install atom

# Recorder, player, and downloader
sudo dnf install -y vlc shutter youtube-dl

# podman, buildah, kubernetes, minikube and not sure about docker.
sudo dnf install -y \
  btrfs-progs-devel \
  conmon \
  containernetworking-cni \
  device-mapper-devel \
  git \
  glib2-devel \
  glibc-devel \
  glibc-static \
  go \
  golang-github-cpuguy83-md2man \
  gpgme-devel \
  iptables \
  libassuan-devel \
  libgpg-error-devel \
  libseccomp-devel \
  libselinux-devel \
  make \
  pkgconfig \
  runc \
  containers-common

# podman, buildag and toolbox
sudo dnf install podman buildah toolbox -y

# Developers packages and cmake to power your compile time ;)
sudo dnf groupinstall -y "Development Tools" "X Software Development"
sudo dnf install -y cmake gcc-c++ make python3-devel ncurses-compat-libs \
    automake cmake gcc gcc-c++ kernel-devel cmake python-devel python3-devel

# install vim 8.4
sudo dnf install -y vim vim-X11

# vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install neovim, no latex because I do not need it
sudo dnf install -y neovim # latexmk

# dependencies/utilities for vim/neovim
sudo dnf install -y xclip xsel
pip install pynvim --user
npm install -g npm
# gem install neovim

# init for neovim
mkdir -p ~/.config/nvim/ && touch ~/.config/nvim/init.vim

# vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# pip install adddons for ranger vim/neovim
pip install ueberzug --user
pip uninstall -y pillow
pip install pillow-simd --user -y

# create directory for compile or source software
mkdir -p ~/.config/source_log


# Wed 03 Jun 2020 11:31:36 PM AST
# version 1.9.2 not working with image preview and ranger
# sudo dnf install -y ranger
pip install ranger-fm --user
# working it is wayland that is not compatible with euberzug
# ranger requirements
pip install flake8 pylint pytest --user

# # install ranger from source/git
# cd /tmp/
# git clone https://github.com/ranger/ranger.git ; cd ranger
# sudo make install
# cp install_log.txt ~/.config/source_log/ranger_install_log
# cd .. && sudo rm -rf ranger

# unistall ranger from source
# sudo rm `cat ranger_install_log`

# devicons for ranger
# ranger --copy-config=all
# ranger --copy-config=rc

git clone https://github.com/alexanderjeurissen/ranger_devicons \
    ~/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf

# not wroking for pip and rpm version, yes for source
# ~/.config/ranger/plugins/ranger_devicons
# make install

# all config from ranger, need testing
# ranger --copy-config=all rc-temp
# map xx chain shell vim -p ~/.config/ranger/rc.conf; source ~/.config/ranger/rc.conf

# colorscheme for ranger
cd ~/.config/ranger
git clone https://github.com/ranger/colorschemes.git
cd ~/.config/ranger/colorschemes
git clone https://github.com/RougarouTheme/ranger
cp ranger/*.py . && rm -rf ranger

# make own colorschemes
# context.py

# install pywal
# pending to search more
# pip install pywal --user

# install NodeJS and yarn
sudo dnf install nodejs npm -y
sudo npm install -g yarn

# install language servers refactor for python
pip install rope --user
sudo npm i -g bash-language-server

# core packages
sudo dnf install -y \
    open-vm-tools sos wget mlocate net-tools which man wget curl lynx \
    traceroute jwhois ytop htop telnet openssh perl ftp deltarpm colorize \
    bash-completion bind-utils ldns ldns-utils chrony rng-tools subnetcalc \
    ipv6calc ipcalc gcc lshw setools-console inotify-tools tcpdump wireshark \
    dstat sysstat ansible psmisc tree

sudo dnf install -y nload iftop iptraf nethogs bmon bwm-ng nmap iperf iperf3

# Installing Pipenv on Fedora
sudo dnf install -y pipenv

# Programming langages

# go, mono, rust
sudo dnf install -y mono-devel golang rust cargo

# insall Rubby
sudo dnf install -y rubygems
# gem install lolcat
# ls -ls | lolcat

# vtop from Node JS
sudo npm install -g vtop

# Restore ssh keys
# ssh-add -l
# chmod 600 ~/.ssh/*
# chmod 644 ~/.ssh/*.pub

# setup zsh and chsh
sudo dnf install -y util-linux-user zsh acpi
# install Oh My Zsh
echo y | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins for oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/gunzy83/packer-zsh-completion.git ~/.oh-my-zsh/plugins/packer

# automatic change shell for zsh or bash for root and current user
sudo chsh -s $(which zsh)
sudo chsh -s $(which zsh) $USER

# echo $EUID
# Fix plain URl without quotes not working in zsh due magic functionssh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# sed "/$_str_0/a $_str_1" $_file_0 | tac| tail -n 10|tac

# install lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit

# Define variables to automate
_file_0="zshrc"
_str_0='export ZSH='
_str_1="DISABLE_MAGIC_FUNCTIONS=true"

_ins_bef(){

local _file_0="$3"
local _str_0="$1"
local _str_1="$2"

sed -i.bk --follow-symlinks "/$_str_0/i $_str_1" "$_file_0"

# display usage message and exit in case not arguments are not pass
_display_usage(){
    echo "Usage: $0 string 1 and 2 and file"
    # exit 1
}
# [ $# -eq 0 ] && _display_usage
# check whether user had supplied -h or --help . If yes display usage
[[ ( $# == "--help") ||  $# == "-h" ]] && _display_usage; echo test # exit 0

}

_ins_bef $_str_0 $_str_1 $_file_0

# History size for zsh and bash
_file_0="$HOME/.oh-my-zsh/lib/history.zsh"
_msg_0='File not found'
_str_0='HISTSIZE='
_str_1='HISTSIZE=9000000'
_str_2='SAVEHIST='
_str_3='SAVEHIST=8000000'

[ -f "$_file_0" ] && sed -i "/$_str_0/c"$_str_1"" $_file_0 || echo "$_msg_0"
[ -f "$_file_0" ] && sed -i "/$_str_2/c"$_str_3"" $_file_0 || echo "$_msg_0"

# zsh manual plugins
# podman
mkdir ~/.oh-my-zsh/plugins/podman ; cd ~/.oh-my-zsh/plugins/podman
curl -O https://raw.githubusercontent.com/containers/libpod/master/completions/zsh/_podman

# for bluidah
# mkdir ~/.oh-my-zsh/plugins/buildah ; cd ~/.oh-my-zsh/plugins/buildah

# Command-line fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc
source ~/.zshrc

# Advance searchers
sudo dnf install the_silver_searcher ripgrep fd-find -y

# install pygments or choma
sudo pip install Pygments

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

# install fontforge for patchfonts
sudo dnf install fontforge -y;

# patch your own font with font-patcher
# Thu 04 Jun 2020 11:21:38 AM AST
# https://github.com/ryanoasis/nerd-fonts#font-patcher

# pip install git+git://github.com/HR/github-clone#egg=ghclone --user
# mkdir font-patcher; cd font-patcher
# ghclone https://github.com/ryanoasis/nerd-fonts/tree/master/src/glyphs
# curl -L https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/font-patcher --output font-patcher

# clone of file and using svn
# And to clone just use the export parameter with fake-dir:
# trunk between the repository and the subdirectory, example:
# svn export [repository]/trunk/[subdirectory]
# https://en.terminalroot.com.br/how-to-clone-only-a-subdirectory-with-git-or-svn/
cd $HOME && rm -rf nerd-fonts && mkdir nerd-fonts && cd nerd-fonts
svn export https://github.com/ryanoasis/nerd-fonts/trunk/src/glyphs src/glyphs
svn export https://github.com/ryanoasis/nerd-fonts/trunk/font-patcher

# # function for automate
# git-svn(){
#   if [[ ! -z "$1" && ! -z "$2" ]]; then
#           echo "Starting clone/copy ..."
#           repo=$(echo $1 | sed 's/\/$\|.git$//')
#           svn export "$repo/trunk/$2"
#   else
#           echo "Use: git-svn <repository> <subdirectory>"
#   fi
# }
#
# git-svn [repository] [subdirectory]
# git-svn https://github.com/ryanoasis/nerd-fonts src/glyphs

# download font default gnome firefox
cd $HOME/nerd-fonts
curl -O https://www.fontsquirrel.com/fonts/download/dejavu-serif
unzip dejavu-serif -d dejavu-serif-directory
rm -rf dejavu-serif; mv dejavu-serif-directory dejavu-serif
# python font-patcher dejavu-serif/DejaVuSerif.ttf
python font-patcher -c dejavu-serif/DejaVuSerif.ttf

# # depth and partial clone
# cd ~; rm -rf nerd-fonts; mkdir nerd-fonts; cd nerd-fonts
# git init
# git remote add origin https://github.com/ryanoasis/nerd-fonts
# # git config core.sparsecheckout true
# echo "src/glyphs" >> .git/info/sparse-checkout
# echo "font" >> .git/info/sparse-checkout
# git pull --depth=1 origin master

# Setup enpass (password manager)
cd /etc/yum.repos.d/
[ ! -f enpass-yum.repo ] && sudo wget https://yum.enpass.io/enpass-yum.repo
sudo dnf install -y enpass

# web brosers and mail
sudo dnf install -y firefox thunderbird

# install tilix
sudo dnf install -y tilix tilix-nautilus

# Fix tilix issue VTE Configuration
#_file_0='$HOME/.zshrc'
#[ -f "$_file_0" ] && sudo bash -c "cat >> .zshrc" <<-'EOF'

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
git config --global user.email "$_my_email_0"
git config --global user.name "$_my_name"
git config --global commit.gpgSign true
git config --global user.signingkey $_git_signing_key

# disable wayland and use x11 must reboot to take effect
# use the function ins_bef
_file_0="/etc/gdm/custom.conf"
_str_0='WaylandEnable='
_str_1='WaylandEnable=false'

sudo sed -i.bk --follow-symlinks "/$_str_0/c $_str_1" "$_file_0"

# install gnome stuff post
sudo dnf install -y gnome-tweak-tool \
    remmina-gnome-session.x86_64


# themes
mkdir -p ~/.local/share/{icons,themes}
sudo dnf install -y yaru-gtk3-theme flat-remix-gtk3-theme

# tweaks for gnome

# set tilix as the default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec tilix
#sudo gsettings set org.gnome.desktop.default-applications.terminal exec tilix

# install gnome extensions from terminal


# cgroups v2 is not woking for kubernetes, docker, snap and kind, and kvm
# so must be downgrade it until a patch for it is done
sudo dnf install -y grubby && sudo grubby \
  --update-kernel=ALL \
  --args="systemd.unified_cgroup_hierarchy=0"

# compile kernel for new hardware
sudo dnf install -y gcc flex make bison openssl-devel elfutils-libelf-devel
sudo dnf install -y fedpkg fedora-packager rpmdevtools ncurses-devel pesign grubby
sudo dnf install -y qt3-devel libXi-devel gcc-c++

# hwinfo and others
sudo dnf install -y hwinfo

# Unit testing for bash and zsh
sudo dnf install shunit2 -y

# install jq for json processing
sudo dnf install -y jq

# Enable ssh or disabled it.
sudo systemctl start sshd && sudo systemctl enable sshd

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


# invoke function from other user or using sudo
# function1(){
#    echo `whoami`
# }
# export -f function1
# # su root -c "bash -c function1"
# exit 0

# function myfunc() {
#     whoami
#     echo First parameter is $1
# }
#
# myfunc foo
# _Declare_0=`declare -f myfunc`
# sudo bash -c "$_Declare_0; myfunc bar"

# search and replace: the 3s, means the thrid line not the third time that occurs,
# and the /2 or /g after the for the matching line.
# sed "3s/"mit"/'algo'/2" license
