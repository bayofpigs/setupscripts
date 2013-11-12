#!/bin/bash

# Make sure that root is running this script
# if [[ $EUID -ne 0 ]]; then
#    echo "This script must be run as root" 1>&2
#    exit 1
# fi

# 1. Install software
sudo apt-get update

# Vim and Emacs 
sudo apt-get install vim emacs

# clone vundle
sudo git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Build Essential, Libssl-dev, curl, wget
sudo apt-get install build-essential libssl-dev
sudo apt-get install curl wget

# Nodejs, Node Version Manager
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Ruby, Ruby Version Manager, RubyGems, Rails
\curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
gem install rails

# Link bashrc and vimrc
cd $HOME
if [ -f ~/.vimrc ]; then
  read -p "Replace existing vimrc? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv .vimrc backup_vimrc
  fi
fi

if [ -f ~/.bashrc ]; then
  read -p "Replace existing bashrc? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv .bashrc backup_bashrc
  fi
fi

ln -sb setupscripts/.bashrc .
ln -sb setupscripts/.vimrc .

if [ -f ~/.bashrc_custom ]; then
  touch .bashrc_custom
fi
