#!/bin/bash

# Make sure that root is running this script
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# 1. Install software
apt-get update

# Vim and Emacs 
apt-get install vim emacs

# clone vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Build Essential, Libssl-dev, curl, wget
apt-get install build-essential libssl-dev
apt-get install curl wget

# Nodejs, Node Version Manager
apt-get update
apt-get install -y python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install nodejs

curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Ruby, Ruby Version Manager, RubyGems, Rails
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current
gem install rails

# Link bashrc and vimrc
ln -s .vimrc ~/.vimrc
ln -s .bashrc ~/.bashrc
