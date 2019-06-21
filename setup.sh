#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential libncurses5-dev cmake python-pip bc bash-completion

vim_version=$(vim --version | head -1 | grep -o '[0-9]\.[0-9]')
if [ $(echo "$vim_version < 8.0" | bc -l) -eq 1 ]; then
    echo "Upgrading vim from $vim_version to 8!"
    sudo apt-get remove vim vim-runtime vim-tiny vim-common
    git clone https://github.com/vim/vim.git /home/vagrant/vim
    cd /home/vagrant/vim
    ./configure --with-features=huge --enable-multibyte
    sudo make install
fi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/local/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

cd /home/vagrant/localdev
if [ ! -d "/home/vagrant/.bashrc" ]; then
    cp bashrc ~/.bashrc
fi

if [ ! -d "/home/vagrant/.gitconfig" ]; then
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
fi

if [ ! -d "/home/vagrant/.vim/bundle/Vundle.vim" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git /home/vagrant/.vim/bundle/Vundle.vim
fi

if [ ! -d "/home/vagrant/.vimrc" ]; then
    cp vimrc /home/vagrant/.vimrc
fi

vim +PluginInstall +qall &>/dev/null
cp mydark.vim /home/vagrant/.vim/bundle/vim-airline/autoload/airline/themes/

# Yarn
if ! [ -x "$(command -v yarn)" ]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install -y yarn
fi

# Postgres
sudo apt-get install -y postgresql postgresql-contrib

pip install --upgrade pip
pip install --user tmuxp
if [ ! -d "/home/vagrant/.tmuxp" ]; then
    cp -R tmuxp /home/vagrant/.tmuxp
fi

if [ ! -d "/home/vagrant/.tmux" ]; then
    git clone --recursive https://github.com/nathanmoon/tmux-config.git /home/vagrant/.tmux
fi
rm -f /home/vagrant/.tmux.conf
ln -s /home/vagrant/.tmux/.tmux.conf /home/vagrant/.tmux.conf
cd /home/vagrant/.tmux/vendor/tmux-mem-cpu-load
mkdir -p build
cd build
cmake ..
make
sudo make install

cd /home/vagrant/localdev

cp -R bin /home/vagrant/bin
