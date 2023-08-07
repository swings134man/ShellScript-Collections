#!/bin/sh

# Shell Script 유용한 + 테스트 

# 입력값 -> Y/N 여부 function
# # ? 조건문을 한줄로 줄인다. 
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

echo "SHELL TEST"

if inputYN "YN TEST"; then
    echo "Y"
else 
    echo "N"
fi

exit 0
