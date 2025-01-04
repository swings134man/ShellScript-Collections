#!/bin/bash

# Made By Lucas Kang
# Git Address: https://github.com/swings134man

echo "ubuntu Simple Setting Start"

# 1. apt update
apt-get update


# 2. sudo
apt-get install sudo

# 3. etc packages
apt-get install build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip

# 4. Git 1.7.10 version install
cd /usr/src
sudo wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-1.7.10.tar.gz
sudo tar xzf git-1.7.10.tar.gz
cd git-1.7.10

sudo make prefix=/usr/local all
sudo make prefix=/usr/local install

git --version


# finish
echo "simple settings END"

