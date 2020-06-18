#!/usr/bin/env bash
echo 'Must use the secret file in your profile, if not exist create it'
# https://www.gnupg.org/documentation//manuals/gnupg/Unattended-GPG-key-generation.html
# export GNUPGHOME="$(mktemp -d)"
# use the secret file in your profile

cd /tmp/

cat > gpg-key-dsa << EOF
    %echo Generating a basic OpenPGP key
    Key-Type: DSA
    Key-Length: 2048
    Subkey-Type: ELG-E
    Subkey-Length: 2048
    Name-Real: $_my_name
    Name-Comment: x passphrase
    Name-Email: $_my_email_0
    Expire-Date: 1y
    Passphrase: $_gpg_passphrase_0
    # Do a commit here, so that we can later print "done" :-)
    %commit
    %echo done
EOF
gpg --batch --generate-key gpg-key-dsa
rm -rf gpg-key-dsa

cat > gpg-key-rsa <<EOF
    %echo Generating a basic OpenPGP key
    Key-Type: RSA
    Key-Length: 2048
    Subkey-Type: RSA
    Subkey-Length: 2048
    Name-Real: $_my_name
    Name-Comment: x passphrase
    Name-Email: $_my_email_0
    Expire-Date: 1y
    Passphrase: $_gpg_passphrase_0
    # Do a commit here, so that we can later print "done" :-)
    %commit
    %echo done
EOF
gpg --batch --generate-key gpg-key-rsa
rm -rf gpg-key-rsa

# gpg --list-signatures --keyid-format LONG

# To delete with finger print
# gpg --list-sigs  | awk '/pub/{getline; print}' | grep --invert-match '-' \
#     | awk '{$1=$1};1' > gpg-keyid-to-delete

# gpg --batch --yes --delete-secret-and-public-keys `cat gpg-keyid-to-delete`

# Get pgp full signature
# list and grep rsa or dsa, print & tail the after line match and trim spaces
# _git_signing_key=`gpg --list-sigs | grep -A1 'pub   rsa' | tail -1 | awk '{$1=$1;print}'`
# gpg --list-signatures  | grep -A1 'pub   dsa' | tail -1

# Get pgp short signature
# gpg --list-sigs | grep -A3 'pub   dsa'| tail -n -1| awk -F ' ' '{print $3}'
_git_signing_key=`gpg --list-sigs | grep -A3 'pub   rsa' \
    | tail -n -1| awk -F ' ' '{print $3}'`

# sing all the commits and use the gpg key
git config --global commit.gpgSign true
git config --global user.signingkey $_git_signing_key

# gpg --armor --export $_git_signing_key | xclip -selection clipboard

# generate file on /tmp

# display user displa
printf 'Open your favorite SCM via web browser: gitlab and/or github you decide!
and paste the public key where it belongs\n
    This public key will be copy to your clipboard then forgotten for your security sake'

#
_func_gpg_keyid() {
    local _git_signing_key=`gpg --list-sigs | grep -A3 'pub   rsa' \
    | tail -n -1| awk -F ' ' '{print $3}'`

    gpg --armor --export $_git_signing_key | xclip -selection clipboard
}

_func_gpg_keyid

printf '\n \n gpg --armor --export $_git_signing_key | xclip -selection clipboard'

# gpg --armor --export $_git_signing_key | xclip -selection clipboard

# command to grab keyid
# gpg --list-secret-keys --keyid-format long \
#     |grep sec| awk -F "[ /]+" '{print $3}' > gpg-keyid-to-delete

# gpg --list-sigs --keyid-format long \
    # |grep sec| awk -F " " '{print $1}' > gpg-keyid-to-delete

