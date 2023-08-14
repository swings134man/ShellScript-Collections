#!/bin/bash

# Made By Lucas Kang
# Git Address : https://github.com/swings134man


# Docker - Container 내부의 Ubuntu 기본 세팅.
  # setting List
    # - apt update
    # - sudo
    # - kor-utf8
    # - curl
    # - net-tools
    # - vim 설치, setting
    # - git
    # - JAVA 11 (2023-08-14 추가)


# Logger
logger() {
  local variant="${1:-info}"
  local message="${2:-}"

  if [ -z "$message" ]; then
    return
  fi

  case "$variant" in
    info)
      printf "\033[34m%-8s\033[0m %s\n" "info" "$message"
      ;;
    success)
      printf "\033[32m%-8s\033[0m %s\n" "success" "$message"
      ;;
    warning)
      printf "\033[33m%-8s\033[0m %s\n" "warning" "$message"
      ;;
    error)
      printf "\033[31m%-8s\033[0m %s\n" "error" "$message"
      ;;
  esac
}

# Y/N 체크
inputYN() {
   local message="${1:-}"
   echo "$message (Y/N)? "
   while read answer; do
       if [[ $answer = [YyNn] ]]; then
       [[ $answer = [Yy] ]] && rtn=0
       [[ $answer = [Nn] ]] && rtn=1
       break
       fi
   done

   return $rtn
}


#  Settings start
logger "info" "Ubuntu Basic Settings Start!"
echo ""


# 1. apt-update
logger "info" "apt-get update"
apt-get update

sleep 1
echo ""

# 2. sudo install
logger "info" "sudo-install"
apt-get install sudo

sleep 1

# 3. kor utf8 install
logger "info" "kor-utf8 setting"

locale-gen ko_KR.UTF-8
# ko_KR.UTF-8 의 번호를 기입하여 세팅.
dpkg-reconfigure locales
update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX

echo ""

# 4. net-tools
logger "info" "install net-tools"
apt-get install net-tools

echo ""
sleep 2

# 5. vim 설치 및 설정
logger "info" "install vim & setting"
apt-get install vim

cat << EOF >> ~/.vimrc
 set number    " line 표시
 set ai    " auto indent
 set si " smart indent
 set cindent    " c style indent
 set shiftwidth=4    " 자동 공백 채움 시 4칸
 set tabstop=4    " tab을 4칸 공백으로
 set ignorecase    " 검색 시 대소문자 무시
 set hlsearch    " 검색 시 하이라이트
 set nocompatible    " 방향키로 이동 가능
 set encoding=utf-8  " utf8 인코딩
 set fileencodings=utf-8,euc-kr    " 파일 저장 인코딩 : utf-8, euc-kr
 set fencs=ucs-bom,utf-8,euc-kr    " 한글 파일은 euc-kr, 유니코드는 유니코드
 set bs=indent,eol,start    " backspace 사용가능
 set ruler    " 상태 표시줄에 커서 위치 표시
 set title    " 제목 표시
 set showmatch    " 다른 코딩 프로그램처럼 매칭되는 괄호 보여줌
 set wmnu    " tab 을 눌렀을 때 자동완성 가능한 목록
 syntax on    " 문법 하이라이트 on
 filetype indent on    " 파일 종류에 따른 구문 강조
 set mouse=a    " 커서 이동을 마우스로 가능하도록
EOF

info "info" ".vimrc File Setting Success -> /root/.vimrc"
echo ""

# 6. git 설치
apt-get install git

git config --global core.precomposeunicode true
git config --global core.quotepath false

logger "info" "⏩️ [git] setting git global properties..."
logger "info" "⏩️ [git] user name:"
    read -r name
    git config --global user.name "${name}"

logger "info" "⏩️ [git] user email:"
    read -r email
    git config --global user.email "${email}"


  sleep 1

echo ""

#6. JAVA 11 Install & setting
logger "info" "JAVA 11 INSTALL"
sleep 1

apt install openjdk-11-jdk
echo ""

logger "info" "Check installed Java Version"
java -version
slepp 2

echo ""
cat << EOF >> ~/.bashrc


  export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
  export PATH=$PATH:$JAVA_HOME/bin

EOF

sleep 1
source ~/.bashrc
sleep 1

logger "info" "JAVA_HOME"
echo $JAVA_HOME

echo ""
logger "info" "All Setting Success"