#!/bin/sh

# Git Push 자동화 Script

date=`date`
SourceDir="Directory"

# Dir Setting
echo "Write for push, Directory"
read DIR

SourceDir=${DIR}
echo "\n"
echo "Location=$SourceDir"
echo "List -->"
ls
echo "\n"
cd $SourceDir

git status

### git commands
# git Add Logic
checkAdd=""
while [ "$checkAdd" != "Y" ] && [ "$checkAdd" != "N" ]; do
    echo "Are You Sure To Add? (Y/N)" 
    read checkAdd

    if [ "$checkAdd" = "N" ]; then
            echo "script Exit!!!" 
            exit 0
    elif [ "$checkAdd" = "Y" ]; then 
            echo "git add -A"
            git add -A
            git status
    else 
        echo "ReWrite Again"
        echo "\n"
    fi
done

echo "\n"

# git Commit Logic 
checkCommit=""
while [ "$checkCommit" != "Y" ] && [ "$checkCommit" != "N" ]; do
    echo "Are You Sure To Commit? (Y/N)"
    read checkCommit

    if [ "$checkCommit" = "N" ]; then
        echo "Git Commit Cancled !!"
        git reset HEAD
        exit 0
    elif [ "$checkCommit" = "Y" ]; then    
        echo "\n"
        echo "Insert Commit Message"
        read commitMessage

        git commit -m "$commitMessage"
    else
        echo "ReWrite Again"    
        echo "\n"
    fi
done

# git push
checkPush=""
while [ "$checkPush" != "Y" ] && [ "$checkPush" != "N" ]; do
    echo "Are You Push your Commit (Y/N)?"
    read checkPush

    if [ "$checkPush" = "N" ]; then
        echo "Git Push Cancled !!"
        git reset --mixed HEAD^
        exit 0
    elif [ "$checkPush" = "Y" ]; then    
        echo "\n"
        git push
    else
        echo "ReWrite Again"    
        echo "\n"
    fi
done

echo "\n"
git status 
echo "\n"

exit 0