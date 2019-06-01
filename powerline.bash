# User specific

# Change script to match OS version and python 20190109 17:47

pip uninstall --yes powerline-status
pip3 uninstall --yes powerline-status

pip3 install --user --upgrade lxml

# powerline urrent development version
pip install --user powerline-status

# powerline urrent development version
# pip3 install --user git+git://github.com/powerline/powerline
pip3 show powerline-status

VarX0="powerline-daemon -q"
FileX0=~/.bashrc
PPathX0=bindings/bash/powerline.sh
repository_root=$(pip3 show powerline-status | grep Location | awk '{print $2;}')

if grep -Eq  "$VarX0" "$FileX0"
then
    echo "Powerline Code found in $FileX0"
else
    echo "Code not found in $FileX0, installing code for poweline from source"
cat >> ~/.bashrc << 'EOF'
# Source for powerline from git or OS package
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
EOF
cat >> ~/.bashrc << EOF
    . $repository_root/powerline/bindings/bash/powerline.sh
fi
EOF
    echo "Executing powerline reload"
fi

# reload powerline for bash
powerline-daemon --replace

# reload powerline for zsh
# powerline-config --reload

# for powerline from OS
# VarX0="powerline-daemon -q"
# FileX0=~/.bashrc
# PPathX0=bindings/bash/powerline.sh
# repository_root=$(pip3 show powerline-status | grep Location | awk '{print $2;}')
#
# if grep -Eq  "$VarX0" "$FileX0"
# then
#     echo "Powerline Code found in $FileX0"
# else
#     echo "Code not found in $FileX0, installing code for poweline from source"
# cat >> ~/.bashrc << EOF
# # Source for powerline from git or OS package
# if [ -f `which powerline-daemon` ]; then
#   powerline-daemon -q
#   POWERLINE_BASH_CONTINUATION=1
#   POWERLINE_BASH_SELECT=1
# . /usr/share/powerline/bash/powerline.sh
# # $repository_root/powerline/bindings/bash/powerline.sh
# fi
# EOF
# fi
#

# Check if file powerline font exists or directory
# File="$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf"
# if [ -f "$File" ]
#     then
#         echo "Powerline Fonts already installed..."
# else
#         echo "Installing Powerline Fonts from source..."
# # Clone
# git clone https://github.com/powerline/fonts.git --depth=1
#
# # Install
# cd fonts
# ./install.sh
# # clean-up a bit
# cd .. && rm -rf fonts
# fi
#
# check if code/word for powerline exists for local .vimrc file
# VarX0='set laststatus=2'
# FileX0=~/.vimrc
#
# if grep -Eq  "$VarX0" "$FileX0"
# then
#     echo "Code for powerline vim found in $FileX0"
# else
#     echo "Code not found in $FileX0"
# cat >> ~/.vimrc <<-'EOF'
# "powerline-status vim statusline
# python3 from powerline.vim import setup as powerline_setup
# python3 powerline_setup()
# python3 del powerline_setup
# set laststatus=2 " Always display the statusline in all windows
# set showtabline=2 " Always display the tabline, even if there is only one tab
# set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
# set rtp+=/usr/lib/python3.7/site-packages/powerline/bindings/vim/
# set t_Co=256
# EOF
# fi

# Check if code/word for tabs exists for local .vimrc file
# VarX0='set tabstop=4'
# FileX0=~/.vimrc
#
# if grep -Eq  "$VarX0" "$FileX0"
# then
#     echo "Code for tabs in vim found in $FileX0"
# else
#     echo "Code not found in $FileX0 inserting code in file anteriormente mencionado"
# cat >> ~/.vimrc <<-'EOF'
#
# ""#To avoid pasting commented on all lines when you have one commented line
# ""On pressing tab, insert 4 spaces
# set expandtab
# ""tab is equal to 4 and autoindent is mark with >
# filetype plugin indent on
# ""show existing tab with 4 spaces width
# set tabstop=4
# ""when indenting with '>', use 4 spaces width
# set shiftwidth=4
# ""set  paste disable autoindent in vim
# set pastetoggle=<F2>
# EOF
# fi
#

#ile="$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf"
#f [ -f "$File" ]
#hen
#   echo "$File found."
#lse
#   echo "$File not found."
# "Not in here"

# powerline-gitstatus
# pip3 install --user powerline-gitstatus
#
# vim /home/ricardo/.local/lib/python3.7/site-packages/powerline/config_files/colorschemes/shell/default.json powerline-gitstatus
