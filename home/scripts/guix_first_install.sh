#!/bin/bash

echo "Install my dotfiles"
git clone https://github.com/easilok/dotfiles.git && cd git/dotfiles/home/scripts && ./linking_dotfiles

echo "Install shell"
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install vim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall

