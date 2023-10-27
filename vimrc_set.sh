#!/bin/zsh

echo "Start vimrc setting ..."

sleep 3

#cat << EOF >> ~/.vimrc
# set number    " line 표시
# set ai    " auto indent
# set si " smart indent
# set cindent    " c style indent
# set shiftwidth=4    " 자동 공백 채움 시 4칸
# set tabstop=4    " tab을 4칸 공백으로
# set hlsearch    " 검색 시 하이라이트
# set nocompatible    " 방향키로 이동 가능
# set ruler    " 상태 표시줄에 커서 위치 표시
# set title    " 제목 표시
# set showmatch    " 다른 코딩 프로그램처럼 매칭되는 괄호 보여줌
# set wmnu    " tab 을 눌렀을 때 자동완성 가능한 목록
# syntax on    " 문법 하이라이트 on
# set mouse=a    " 커서 이동을 마우스로 가능하도록
#EOF

sleep 1

echo "Vimrc setting success!"
echo ""

confirmMessage=""
echo "Show vimrc file? (Y/N)"
read confirmMessage

confirmMessage=$(echo "$confirmMessage" | tr '[:upper:]' '[:lower:]')

if [ "$confirmMessage" = "y" ]; then
    vim ~/.vimrc
else
    echo "Vimrc setting success!"
    exit 0
fi