#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential libncurses5-dev cmake python-pip

sudo apt-get remove vim vim-runtime vim-tiny vim-common
git clone https://github.com/vim/vim.git /home/ubuntu/vim
cd /home/ubuntu/vim
./configure --with-features=huge --enable-multibyte
sudo make install

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

#sudo update-alternatives --set editor /usr/bin/vim.basic
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/local/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

cd /home/ubuntu/localdev
cp bashrc ~/.bashrc

cp gitconfig ~/.gitconfig


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

git clone https://github.com/gmarik/Vundle.vim.git /home/ubuntu/.vim/bundle/Vundle.vim

cp vimrc /home/ubuntu/.vimrc

vim +PluginInstall +qall

pip install --user tmuxp
cp -R tmuxp /home/ubuntu/.tmuxp

git clone --recursive https://github.com/nathanmoon/tmux-config.git /home/ubuntu/.tmux
ln -s /home/ubuntu/.tmux/.tmux.conf /home/ubuntu/.tmux.conf
cd /home/ubuntu/.tmux/vendor/tmux-mem-cpu-load
mkdir build
cd build
cmake ..
make
sudo make install

cd /home/ubuntu/localdev

cp -R bin /home/ubuntu/bin
