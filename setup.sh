#!/bin/bash

# Workstation setup

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

# Node packages
sudo npm install -g nodemon
sudo npm install -g express
sudo npm install -g express-generator
sudo npm install -g grunt-cli

# Redis
# Add a redis user
sudo adduser --system --no-create-home --disabled-login --disabled-password --group redis
wget http://download.redis.io/releases/redis-2.8.12.tar.gz
tar xzf redis-2.8.12.tar.gz
cd redis-2.8.12
make
sudo make install
sudo mkdir /etc/redis
# Copy redis configuration
sudo cp redis.conf /etc/redis
cd ..
sudo cp redis.conf /etc/init/

# Mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-org

# nginx
# =====
# Required packages
sudo apt-get install libpcre3-dev libssl-dev

# Make an nginx user (www-data)
sudo adduser --system --no-create-home --disabled-login --disabled-password --group www-data
# Fetch modules
sudo git clone https://github.com/masterzen/nginx-upload-progress-module/ /opt/nginx-upload-progress-module
wget http://nginx.org/download/nginx-1.7.0.tar.gz
tar xzf nginx-1.7.0.tar.gz
cd nginx-1.7.0
./configure --prefix=/opt/nginx --user=www-data --group=www-data --with-http_ssl_module --add-module=/opt/nginx-upload-progress-module --conf-path=/etc/nginx/nginx.conf --with-http_realip_module --with-file-aio --with-http_flv_module --with-http_mp4_module --with-http_stub_status_module --with-ipv6
make && sudo make install
sudo ln -s /opt/nginx/sbin/nginx /usr/local/bin
cd ..
# Add configuration file for the service
sudo cp nginx.conf /etc/init/nginx.conf
# Set up permissions
sudo chown -R www-data:www-data /opt/nginx
sudo chown -R www-data:www-data /etc/nginx

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
