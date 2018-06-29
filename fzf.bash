#!/bin/bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
source ~/.bashrc

#To exec as function instead of exec bash
function reload! () {
    echo "Reloading bash profile...!"
    source ~/.bash_profile
    echo "Reloaded!!!"
}

reload!






#Vx0="Not empty Original session"
#echo $Vx0
#exec bash
#echo $Vx0
#Vx1="Not empty new session"
#echo $Vx1
#exit
#echo "Test Orginal Variable" $Vx0
#echo "Test Second Variable" $Vx1
#



