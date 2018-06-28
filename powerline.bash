#user specific

pip install --user --upgrade lxml
pip install --user git+git://github.com/powerline/powerline
pip show powerline-status

VarX0="powerline-daemon -q"
FileX0=~/.bashrc
PPathX0=bindings/bash/powerline.sh
repository_root=$(pip show powerline-status | grep Location | awk '{print $2;}')


if grep -Eq  "$VarX0" "$FileX0"
then
    echo "Code found in $FileX0"
else
    echo "Code not found in $FileX0, installing code for poweline from source"
cat >> ~/.bashrc << EOF
 if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
. $repository_root/powerline/bindings/bash/powerline.sh 
fi
EOF


fi

#check if file powerline font exists or directory 
File="$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf"
if [ -f "$File" ]
    then
        echo "Powerline Fonts already installed..."
else
        echo "Installing Powerline Fonts from source..."
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd .. && rm -rf fonts
fi

#check if code/word for powerline exists for local .vimrc file 
VarX0='set laststatus=2'
FileX0=~/.vimrc

if grep -Eq  "$VarX0" "$FileX0"
then
    echo "Code found in $FileX0"
else
    echo "Code not found in $FileX0"
cat >> ~/.vimrc <<-'EOF'
"powerline-status vim statusline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set  rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/
set t_Co=256
EOF
fi

#check if code/word for tabs exists for local .vimrc file 
VarX0='set tabstop=4'
FileX0=~/.vimrc

if grep -Eq  "$VarX0" "$FileX0"
then
    echo "Code found in $FileX0"
else
    echo "Code not found in $FileX0"
cat >> ~/.vimrc <<-'EOF'

""#To avoid pasting commented on all lines when you have one commented line
""On pressing tab, insert 4 spaces
set expandtab
""tab is equal to 4 and autoindent is mark with > 
filetype plugin indent on
""show existing tab with 4 spaces width
set tabstop=4
""when indenting with '>', use 4 spaces width
set shiftwidth=4
""set  paste disable autoindent in vim 
set pastetoggle=<F2>
EOF
fi


#ile="$HOME/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf"
#f [ -f "$File" ]
#hen
#   echo "$File found."
#lse
#   echo "$File not found."
#i

