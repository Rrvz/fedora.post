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

# get pgp for signature
_git_signing_key=`gpg --list-sigs | grep -A1 'pub   rsa' | tail -1 | awk '{$1=$1;print}'`
# gpg --list-signatures  | grep -A1 'pub   dsa' | tail -1

#
git config --global user.signingkey $_git_signing_key

gpg --armor --export $_git_signing_key
gpg --armor --export $_git_signing_key | xclip -selection clipboard

# generate file on /tmp
cd /tmp
gpg --armor --export $_git_signing_key > rsa-key

# display user display
echo 'execute this command on your awesome terminal'
echo 'open your favorite SCM: gitlab or github you decide! '
echo '\n This file will be deleted in one minute for your sake security'
echo xclip -selection clipboard < rsa-key

rm /tmp/rsa-key | at now +1m

# command to grab keyid
# gpg --list-secret-keys --keyid-format long \
#     |grep sec| awk -F "[ /]+" '{print $3}' > gpg-keyid-to-delete

# gpg --list-sigs --keyid-format long \
    # |grep sec| awk -F " " '{print $1}' > gpg-keyid-to-delete

