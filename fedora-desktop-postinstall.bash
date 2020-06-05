#!/usr/bin/env bash

# Add to file in sudoers directory
sudo bash -c "cat > /etc/sudoers.d/users" <<-'EOF'
%wheel  ALL=(ALL)   NOPASSWD: ALL
EOF

#Fix dnf problem unable to install because a : No match for argument:
#gir1.2-clutter, error: Unable to find a match
_File0="/etc/dnf/dnf.conf"
_Str0="strict="
_Str1="strict=False"
if [ ! -z $(grep "$_Str0" "$_File0") ]; then
    if [ ! -z $(grep "$Str1" "$_File0") ]; then
        echo "$Str1 value is already in file"
    else
        sudo sed -i.bk --follow-symlinks "/$_Str0/c $_Str1" $_File0
    fi
else
sudo bash -c "echo "$_Str1" >> /etc/dnf/dnf.conf"
echo "$_Str1 value added to $_File0"
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

# more codecs
sudo dnf -y install ffmpeg2theora ffmpeg mencoder
sudo dnf -y install libdvdread libdvdnav lsdvd libdvdcss

# install for ipv6 radvd git subversion
sudo dnf install -y radvd tcpdump

# install for git subversion
sudo dnf install -y git gitk colordiff diffutils subversion

# send mail from local
sudo dnf install -y mailx sendmail

# Compression utilities
sudo dnf -y install unrar p7zip p7zip-plugins tar

# imagenes las mejores :)
sudo dnf -y install converseen gimp

# Source code editors
sudo dnf -y install \
atom \
https://az764295.vo.msecnd.net/stable/d69a79b73808559a91206d73d7717ff5f798f23c/code-1.45.0-1588868440.el7.x86_64.rpm

# Recorder, player, and downloader
sudo dnf install -y vlc shutter youtube-dl

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
sudo dnf install xclip xsel
pip install pynvim
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
context.py

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

# setup zsh
sudo dnf install -y util-linux-user zsh acpi
# install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fix plain URl without quotes not working in zsh due magic functions
# sed "/$Str0/a $Str1" $File0 | tac| tail -n 10|tac

# install lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit

# Define variables to automate
_File0="zshrc"
_Str0='export ZSH='
_Str1="DISABLE_MAGIC_FUNCTIONS=true"

_ins_bef(){

local _File0="$3"
local _Str0="$1"
local _Str1="$2"

sed -i.bk --follow-symlinks "/$_Str0/i $_Str1" "$_File0"

# display usage message and exit in case not arguments are not pass
_display_usage(){
    echo "Usage: $0 string 1 and 2 and file"
    # exit 1
}
# [ $# -eq 0 ] && _display_usage
# check whether user had supplied -h or --help . If yes display usage
[[ ( $# == "--help") ||  $# == "-h" ]] && _display_usage; echo test # exit 0

}

_ins_bef $_Str0 $_Str1 $_File0

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

pip install git+git://github.com/HR/github-clone#egg=ghclone --user

mkdir font-patcher; cd font-patcher
ghclone https://github.com/ryanoasis/nerd-fonts/tree/master/src/glyphs

curl -L https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/font-patcher --output font-patcher

# clone of file and using svn
# And to clone just use the export parameter with fake-dir:
# trunk between the repository and the subdirectory, example:
# svn export [repository]/trunk/[subdirectory]
# https://en.terminalroot.com.br/how-to-clone-only-a-subdirectory-with-git-or-svn/
cd ~; rm -rf nerd-fonts; mkdir nerd-fonts; cd nerd-fonts
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
curl -O https://www.fontsquirrel.com/fonts/download/dejavu-serif
unzip dejavu-serif -d dejavu-serif-directory
rm -rf dejavu-serif; mv dejavu-serif-directory dejavu-serif
#
mkdir unpatched-fonts
cd ~; cd nerd-fonts
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
git config --global user.email "$_my_email_0"
git config --global user.name "$_my_name"
git config --global commit.gpgSign true


# disable wayland and use x11 must reboot to take effect
# use the function ins_bef
_File0="/etc/gdm/custom.conf"
_Str0='WaylandEnable='
_Str1='WaylandEnable=false'

sudo sed -i.bk --follow-symlinks "/$_Str0/c $_Str1" "$_File0"

# themes
mkdir -p ~/.local/share/{icons,themes}
sudo dnf install yaru-gtk3-theme flat-remix-gtk3-theme

# tweaks for gnome

# set tilix as the default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec tilix
#sudo gsettings set org.gnome.desktop.default-applications.terminal exec tilix

# install gnome extensions from terminal


#

# install snapd
sudo dnf install -y snapd



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
