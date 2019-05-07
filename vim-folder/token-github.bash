#!/usr/bin/env bash

# Declare Variables
Bashrc_file_x00="$HOME/.bashrc"
Token_x00="GITHUB_TOKEN"
Token_x01='GITHUB_TOKEN="8867e99ce0479d34a8d34f0a96bfe6ee001e4b0e"'

if [ ! -z $(grep "$Token_x00" "$Bashrc_file_x00") ]; then
    if [ ! -z $(grep "$Token_x01" "$Bashrc_file_x00") ]; then
        echo "Token_x01 value is already in file"
    else
        sudo sed -i "/$Token_x00/c $Token_x01" $Bashrc_file_x00
    fi
else
sudo cat <<EOF >> "$Bashrc_file_x00"

# Source for Vim Git autthentication junegunn/vim-github-dashboard
export $Token_x01
EOF
echo "String_x1 value added to $Bashrc_file_x00"
fi
source $Bashrc_file_x00
