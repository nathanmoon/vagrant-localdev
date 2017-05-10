#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

cp bashrc ~/.bashrc

cp gitconfig ~/.gitconfig

#sudo update-alternatives --set editor /usr/bin/vim.basic

#echo -n "For git"
#echo -n "Enter your name: "
#read gitname
#echo -n "Enter your email: "
#read gitemail

cat << EOF >> ~/.gitconfig

[user]
    name = "Nathan Moon"
    email = "nathannospam@gmail.com"

EOF

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#cp vimrc ~/.vimrc

#vim +PluginInstall +qall

#cp -R tmuxp ~/.tmuxp

