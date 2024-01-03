#!/bin/zsh

# nvm - node install Script
# This is For Mac OS - zsh - brew
# !!!YOU MUST INSTALL BREW, ZSH FIRST!!!

echo "Start nvm install ..."

# nvm install
brew install nvm
sleep 2

mkdir ~/.nvm

cat << EOF >> ~/.zshrc

  # nvm setting
  export NVM_DIR=~/.nvm
  export $(brew --prefix nvm)/nvm.sh

EOF

sleep 1
source ~/.zshrc
sleep 1

echo "nvm install success!"

sleep 2

# node install
echo ""
echo "node install start ..."

inputVersion=""
echo "Input node version: (version NUMBER ONLY)"
read inputVersion

# validate ONLY NUMBER filter
inputVersion=$(echo "$inputVersion" | tr -cd '[:digit:]')

nvm install $inputVersion

sleep 1

echo "node install success!"

sleep 2

# echo "nvm version: " 뒤에 nvm --version 의 결과 출력
echo "nvm version: " $(nvm --version)
echo "npm version: " $(npm --version)
echo "node version: " $(node --version)
