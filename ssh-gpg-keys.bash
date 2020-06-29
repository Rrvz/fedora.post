#!/usr/bin/env bash

# define messages for keys to display
_message_0='Must use the secret file in your profile and then source it,
if not exist it must created in:
    $HOME/.bashrc or $HOME/.zshrc or your script.
Append the following to the scripts that must use your secrets:
[ -f $HOME/.secrets ] && source $HOME/.secrets'

# define warnings to display
_warning_0="keys exists, it will use the existing key, do a manual \
ssh-keygen to renew key."

_warning_1='The variable $_ssh_passphrase_0 has not been set please add it
to the secret file please.'

# generate/define keys
_key_name_0="$HOME/.ssh/id_mykey"
# source secrets file
[ -f $HOME/.secrets ] && source $HOME/.secrets || \
    { printf "$_message_0 \n" && exit ;}

# check for os variables in your secrets.
[[ -n $_ssh_passphrase_0 ]] || { echo $_warning_1 && exit ;}
# [[ -n $_ssh_passphrase_1 ]] || { echo $_warning_1 && exit ;}

# generate keys based in variables to autmate
[[ -f $_key_name_0 ]] && echo $_warning_0 || \
ssh-keygen -t ed25519 -f $_key_name_0 -N $_ssh_passphrase_0 -C "for gitlab"

# test ssh passphrase:
echo $_ssh_passphrase_0
ssh-keygen -y -f $HOME/.ssh/id_mykey


# sudo dnf install git git-all hub

# Normal one without passphrase
# ssh-keygen -t ed25519 -C "key x@ryzen"
# ssh-copy-id -i ~/.ssh/id_ed25519 root@192.168.220.201

# specific file
# ssh-keygen -t ed25519 -f ~/.ssh/id_ryzen-github -C "key rrvzero@gmail.com"
# with passphrase
# ssh-keygen -t ed25519 -f ~/.ssh/id_passphrase -C "key passphrase x@ryzen"
# old keys
# ssh-keygen -t rsa -b 4096 -f ~/.ssh/vps-cloud.web-server.key -C "My web-server key"

# set in vim ~/.bashrc
# error: unable to read askpass response from '/usr/libexec/openssh/gnome-ssh-askpass'
unset SSH_ASKPASS


# Adding your SSH key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ryzen-github

# upload the public key to github
xclip -sel clip < ~/.ssh/id_ryzen-github.pub

# Testing your SSH connection
ssh -T git@github.com

# check keychain
ssh-add -L

#
git config user.name "rrvz"
git config user.email "rrvzero@gmail.com"

# Generate GPG keys
# Checking for existing GPG keys
