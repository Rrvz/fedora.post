#!/usr/bin/env bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat >> ~/.vimrc << EOF

" Defaults paratemers from vimrc
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=500         " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" set confirm

"powerline-status vim statusline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
"set rtp+=~/.local/lib/python3.7/site-packages/powerline/bindings/vim/
"set rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/
set t_Co=256

" To avoid pasting commented on all lines when you have one commented line
" tab is equal to 4 and autoindent is mark with >
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" set  paste disable autoindent in vim
set pastetoggle=<F2>
" On pressing tab, insert 4 spaces
set expandtab

" set clipboard=unnamed
"if has('clipboard')
"    if has('unnamedplus')  " When possible use + register for copy-paste
"        set clipboard=unnamed,unnamedplus
"    else         " On mac and Windows, use * register for copy-paste
"        set clipboard=unnamed
"    endif
"endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'


call plug#begin('~/.vim/plugged')



