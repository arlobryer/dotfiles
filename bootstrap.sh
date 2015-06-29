#!/bin/bash
set -e
cd "$(dirname "$0")"
git pull
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  rsync --exclude ".git/" --exclude ".DS_Store" -avh ./.* ~
fi
echo "Installing Brew packages"
sh brewinstall.sh
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
source "$HOME/.zshrc"
echo "Installing Atom packages"
sh atompackages.sh
