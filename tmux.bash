#!/usr/bin/env bash

#libs to install
sudo dnf install gcc kernel-devel make ncurses-devel libevent libevent-devel -y
# yum install tmux -y

cd
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure
#./configure --prefix=/usr/local
make
sudo make install
cd
sudo rm tmux -rf

#
#cd
#git clone https://github.com/gpakosz/.tmux.git
#ln -s -f .tmux/.tmux.conf
#cp .tmux/.tmux.conf.local .

#Search for and comment regular glyphs and uncomment powerline fonts

# status left/right sections separators
#cd
#vim .tmux.conf.local

# Set italics on in tmux
set -g default-terminal "tmux" # colors!

# https://github.com/tmux/tmux/issues/1246

# important！24 bit color
#set -g default-terminal "tmux-256color"
#set -ga terminal-overrides ",*256col*:Tc"
set -g default-terminal "tmux-256color"
# enable 24 bit support
set -g terminal-overrides ',xterm-256color:Tc'




#######################################################################



#######################################################################




# It has to be equal to the terminal that yo estoy usando Linux/MacOS
set -g terminal-overrides ',xterm-256color:Tc'
set -g default-terminal "xterm-256color"
#set -as terminal-overrides ',xterm*:sitm=\E[3m'

# reload configuration
bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

# install at OS Level
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#####################################
# Plugins
# https://github.com/tmux-plugins/tpm
####################################

#####################################
# tpm plugin manager
# https://github.com/tmux-plugins/tpm
#####################################
set -g @plugin 'tmux-plugins/tpm'

#####################################
# tmux-sensible - basline settings that get overwritten from .tmux.conf
# https://github.com/tmux-plugins/tmux-sensible
######################################
#set -g @plugin 'tmux-plugins/tmux-sensible'

#####################################
# tmux-resurrect - save and reload sessions and windows after a restart
# https://github.com/tmux-plugins/tmux-resurrect
# Default keybinds : save - command + c + s && restore command + c + r
######################################
set -g @plugin 'tmux-plugins/tmux-resurrect'
### tmux-resurrect extra settings ###
# keep vim sessions after reboot
set -g @resurrect-strategy-vim 'session'
# keep pane contents
set -g @resurrect-capture-pane-contents 'on'
# restore bash history
set -g @resurrect-save-bash-history 'on'
### /tmux-resurrect extra settings ###
# Custom key bindings
# set -g @resurrect-save 'S'
# set -g @resurrect-restore 'R'

######################################
# tmux-continuum - automatically save and restore tmux sessions
# https://github.com/tmux-plugins/tmux-continuum
#####################################
set -g @plugin 'tmux-plugins/tmux-continuum'
# Restore last saved enviroment
set -g @continuum-restore 'on'
# Set autosave interval
set -g @continuum-save-interval '15'
# Show continiuum state in statusbar
# set -g status-right 'Continuum status: #{continuum_status}'
# Starting tmux with system https://github.com/tmux-plugins/tmux-continuum/blob/master/docs/automatic_start.md

######################################
# tmux-yank - advanced copy mode
# https://github.com/tmux-plugins/tmux-yank
#####################################
set -g @plugin 'tmux-plugins/tmux-yank'

# initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'


cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
