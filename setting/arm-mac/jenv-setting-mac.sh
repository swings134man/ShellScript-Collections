#!/bin/zsh

# Made By Lucas Kang
# Jenv setting For ARM Mac

echo "Start Jenv Setting!!"

echo "✅ install jenv (Java environment manager)"
brew install jenv

echo "✅ enable jenv plugin"
jenv enable-plugin export

echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc

echo "✅ jenv setting complete!!"

jenv

echo ""

# Azul zulu jdk 8, 11, 17, 21
brew install zulu@8
brew install zulu@11
brew install zulu@17
brew install zulu@21
echo "✅ jdk 8, 11, 17, 21 install complete!!"

# TODO: check and need to fix
jenv add /Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home
echo "✅ jdk 8, 11, 17 add complete!!"

jenv versions
echo ""

jenv global 17
echo "✅ jdk 17 global setting complete!!"

# jenv local 11

echo "✅ finish jenv setting!!"
