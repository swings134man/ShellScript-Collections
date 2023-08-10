#!/bin/sh

# Shell Script 유용한 + 테스트 

# 출력 형식 정의 
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

logger "info" "THIS IS INFO"

logger "success" "THIS IS SUCCESS"
logger "warning" "THIS IS WARNING"
logger "error" "THIS IS error"

logger "" "TEST"


# 입력값 -> Y/N 여부 function
# # ? 조건문을 한줄로 줄인다. 
# inputYN() {
#     local message="${1:-}"
#     echo "$message (Y/N)? "
#     while read answer; do
#         if [[ $answer = [YyNn] ]]; then
#         [[ $answer = [Yy] ]] && rtn=0
#         [[ $answer = [Nn] ]] && rtn=1
#         break
#         fi
#     done

#     return $rtn
# }

# echo "SHELL TEST"

# if inputYN "YN TEST"; then
#     echo "Y"
# else 
#     echo "N"
# fi

# exit 0

