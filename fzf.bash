#!/bin/bash

OS_DIST_x00="$(hostnamectl | grep "Operating System")"
OS_DIST_x01='Fedora'; OS_DIST_x02='Debian'
if grep -E "$OS_DIST_x01" <<< "$OS_DIST_x00"
then
    sudo dnf install -y the_silver_searcher ripgrep fd-find
else
    grep -Eq "$OS_DIST_x02" <<< "$OS_DIST_x00"
        sudo apt-get update
        sudo apt-get install -y the_silver_searcher ripgrep fd-find
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

Var_x00="FZF_DEFAULT_COMMAND"
Var_x01="FZF_CTRL_T_COMMAND"
File_x00=~/.bashrc

if grep -Eq "$Var_x00|$Var_x01" "$File_x00"
then
    echo "Code found"
else
    echo "not found, Overriding FZF defaults to use FD, AG and hidden files"

cat >> ~/.bashrc << "EOF"
# FZF override Defaults
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden"
EOF
fi

# To exec as function instead of exec bash
function reload! () {
    echo "Reloading bash profile...!"
    source ~/.bash_profile
    echo "Reloaded!!!"
}
reload!


