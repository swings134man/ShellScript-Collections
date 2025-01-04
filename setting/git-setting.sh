#!/bin/sh

cd ~ 


git config --global core.precomposeunicode true
git config --global core.quotepath false

showGitConfig=""

echo "Show Git config? (Y/N)" 
read checkAdd

if [ "$showGitConfig" = "Y" ]; then
    echo "Git Setting Success!"
    exit 0
fi    