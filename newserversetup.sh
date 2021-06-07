#!/usr/bin/env bash

# This script is used to set up a server exactly how it should be set up with the following - 
# modern version of vim - this includes decent plugins - which requires an updated nodejs install
# all symlinks pointing to the dotfiles for the bashrc and vimconfig 

set -e

# choose home dir - this is usually the datadrive - such as /data/callum
read -p "Install base location: " homepath
# # check user is happy
while true; do
    read -p "Do you wish to install vim, nodejs, and symlinks to $homepath? (y, n) " yn
    case $yn in
        [Yy]* ) echo "yes"; break;; #make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo installing to $homepath
# add first links - tmux and bashrc
cd $homepath
ln -sf $homepath/dotfiles/.bashrc ~/.bashrc
ln -sf $homepath/dotfiles/.bash_profile ~/.bash_profile
ln -sf $homepath/dotfiles/.vimrc ~/.vimrc
ln -sf $homepath/dotfiles/.bin ~/.bin
ln -sf $homepath/dotfiles/.tmux ~/.tmux
ln -sf $homepath/dotfiles/.tmux.conf ~/.tmux.conf
# download miniconda and install in the base path  
cd $homepath
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $homepath/miniconda3
# add miniconda path to .bash_profile
echo "PATH=$homepath/miniconda3/bin:\$PATH" >> ~/.bash_profile
# download vim 
cd $homepath
git clone https://github.com/vim/vim.git
cd vim/src
./configure --prefix=$homepath/vim_real --with-features=huge 
# https://superuser.com/questions/162560/how-to-install-vim-on-linux-when-i-dont-have-root-permissions
make && make install
# add new vim path to .bash_profile 
echo "export PATH=$homepath/vim_real/bin:\$PATH" >> ~/.bash_profile
# install newer nodejs
echo "installing nodejs" 
cd $homepath
wget https://nodejs.org/dist/v16.3.0/node-v16.3.0.tar.gz # https://nodejs.org/dist/v15.11.0/node-v15.11.0.tar.gz
tar -xvf node-v16.3.0.tar.gz
cd node-v16.3.0
./configure --prefix=$homepath/nodejs
make && make install
echo "export PATH=$homepath/nodejs/bin:\$PATH" >> ~/.bash_profile
# # add vimrc symlinks 
ln -sf $homepath/dotfiles/.vimrc ~/.vimrc
source ~/.bash_profile 
source ~/.bashrc
# install vim plugs
vim  +VimEnter +PlugInstall +qall
# install vim coc plugins 
vim +"CocInstall coc-pyright" +"CocInstall coc-sh"
# tidy up should go here 
cd $homepath
echo all installed - hopefully. you may need to add a few lines to the bashrc to point to the conda init and restart the shell

# TODO:
# can also add rclone install and openslide install to this
# add a cleanup step 
