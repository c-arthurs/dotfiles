#!/usr/bin/env bash
set -e

# choose home dir
read -p "Install location: " homepath
echo installing to $homepath
# download dotfiles
cd $homepath
# git clone https://github.com/c-arthurs/dotfiles.git
# cd dotfiles
# add first links - tmux and bashrc
cd $homepath
ln -sf $homepath/dotfiles/.bashrc ~/.bashrc
ln -sf $homepath/dotfiles/.bin ~/.bin
ln -sf $homepath/dotfiles/.tmux ~/.tmux
ln -sf $homepath/dotfiles/.tmux.conf ~/.tmux.conf
# download miniconda 
cd $homepath
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $homepath/miniconda3
# add miniconda path to .bash_profile
echo "PATH=$homepath/miniconda3/bin:\$PATH" >> ~/.bash_profile
# download vim 
cd $homepath
git clone https://github.com/vim/vim.git
cd vim
cd src
./configure --prefix=$homepath/vim_real --with-features=huge 
# https://superuser.com/questions/162560/how-to-install-vim-on-linux-when-i-dont-have-root-permissions
make && make install
# add new vim path to .bash_profile 
echo "export PATH=$homepath/vim_real/bin:\$PATH" >> ~/.bash_profile
# install newer nodejs
echo "installing nodejs" 
cd $homepath
wget https://nodejs.org/dist/v15.11.0/node-v15.11.0.tar.gz
tar -xvf node-v15.11.0.tar.gz
cd node-v15.11.0
./configure --prefix=$homepath/nodejs
echo "export PATH=$homepath/nodejs/bin:\$PATH" >> ~/.bash_profile
# # add vim link 
ln -sf $homepath/dotfiles/.vimrc ~/.vimrc
source ~/.bash_profile 
source ~/.bashrc
# install vim plugs
vim  +VimEnter +PlugInstall +qall
echo all installed - hopefully
