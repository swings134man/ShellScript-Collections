#!/bin/bash

# Made By Lucas Kang
# Git Address : https://github.com/swings134man


# Docker - Container 내부의 Ubuntu 기본 세팅.
  # setting List
    # - apt update
    # - sudo
    # - net-tools
    # - vim 설치, setting
    # - git
    # - cron
    # - 시스템 설정
    # - ufw
    # - fail2ban
    # - nginx

# Need to Nginx, fail2Ban, ufw, crontab, sshd Settings


# ------------------ functions ------------------
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

# Cache Clear
cacheClear() {
  sudo sync
  sudo sysctl -w vm.drop_caches=3 # 단일작업 바로 즉시적용
}
# ------------------ functions ------------------
# ------------------ main ------------------
#  Settings start
logger "info" "Oracle Server Ubuntu Settings start"
echo ""

# 1. apt update
logger "info" "Update apt repository"
apt-get update

sleep 1

# 2. sudo install
logger "info" "Install sudo"
apt-get install sudo

sleep 1

cacheClear

# 3. net-tools ----------------------------------------------------------------------------------------
logger "info" "install net-tools"
apt-get install net-tools

echo ""
sleep 2

# 4. vim 설치 및 설정 ----------------------------------------------------------------------------------------
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

cacheClear

sudo chmod 644 /root/.vimrc
sudo chown root:root /root/.vimrc

info "info" ".vimrc File Setting Success -> /root/.vimrc"
echo ""

# 5. git 설치 ----------------------------------------------------------------------------------------
logger "info" "install and setting git"

inputYN "Would you like to install and set git?"

if [ $? -ne 1 ]; then
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
fi

# 6. cron ----------------------------------------------------------------------------------------
logger "info" "install and setting cron"

apt-get install cron

# 7 .system setting ----------------------------------------------------------------------------------------
logger "info" "system setting"

# Set timezone
timedatectl set-timezone Asia/Seoul

cacheClear

# 8. ufw
logger "info" "install and setting ufw"
apt-get install ufw

# Enable UFW
ufw enable

ufw allow 80
ufw allow 443
ufw allow 12322

cacheClear

# 9. fail2ban
logger "info" "install and setting fail2ban"
apt-get install fail2ban
# Enable fail2ban
systemctl enable fail2ban
systemctl start fail2ban
# Check fail2ban status
systemctl status fail2ban

cat << EOF >> /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
backend = systemd
filter = sshd
# 최대 3번 실패시 밴
maxretry = 3
# 10분동안 3번 실패시 밴
findtime = 10m
# 1일 밴 -1 은 영구차단
bantime = 86400
EOF

sudo chmod 644 /etc/fail2ban/jail.local
sudo chown root:root /etc/fail2ban/jail.local

sudo systemctl restart fail2ban

cacheClear

sudo journalctl --vacuum-size=1G
sudo journalctl --vacuum-time=2w

# 8 .etc ----------------------------------------------------------------------------------------
logger "info" "install nginx"

apt-get install nginx

ufw allow Nginx Full

sudo apt install certbot python3-certbot-nginx -y
logger "info" "completed nginx & Certbot install"

echo ""

logger "info" "iptables setting"
sudo iptables -I INPUT 5 -i ens3 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -I INPUT 5 -i ens3 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo apt install iptables-persistent -y
sudo netfilter-persistent save

logger "info" "iptables setting save completed"

echo ""

journalctl --vacuum-size=1G
journalctl --vacuum-time=2w
logger "info" "etc setting log size Limit Completed"

echo ""


# ------------------ main ------------------
logger "success" "Oracle Server Ubuntu Settings completed successfully."
echo ""

logger "info" "you need to setting list"
logger "info" "- nginx"
logger "info" "- fail2ban"
logger "info" "- cron"
logger "info" "- vimrc by user"
logger "info" "- certbot"
