#!/bin/sh

# Brew 를 통한 maria db 실행 

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


cd ~ 

logger "info" "Brew MariaDB Start" 

brew services start mariadb

mysql -uroot -p 
