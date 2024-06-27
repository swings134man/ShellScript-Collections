#!/bin/bash

# Made By Lucas Kang
# Jenv setting

echo "Start Jenv Setting!!"

echo "✅ install jenv (Java environment manager)"
brew install jenv

echo "✅ enable jenv plugin"
jenv enable-plugin export

echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(jenv init -)"' >> ~/.bashrc
source ~/.bashrc

echo "✅ jenv setting complete!!"

jenv

echo ""

brew install openjdk@8
brew install openjdk@11
brew install openjdk@17
echo "✅ jdk 8, 11, 17 install complete!!"

# TODO: check and need to fix
jenv add /usr/local/opt/openjdk@8
jenv add /usr/local/opt/openjdk@11
jenv add /usr/local/opt/openjdk@17
echo "✅ jdk 8, 11, 17 add complete!!"

jenv versions
echo ""

jenv global 17
echo "✅ jdk 17 global setting complete!!"

# jenv local 11

echo "✅ finish jenv setting!!"
