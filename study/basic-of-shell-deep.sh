#!/bin/zsh

# for zsh

# IO: Input Output
# read: Can Read Input
# echo: Can Print Output

read NAME
echo "Hello, $NAME" # $VariableName: Print Variable Value

# Variable
Var_NAME=$NAME # variableName=value (No Space)
echo "VAR, $Var_NAME"

# you can make variable in function
# functionName() {
firstFunc() {
  # 함수 내부의 지역변수 선언 가능.
  # 1:- = 첫번쨰 인자가 없을경우, 기본 값은 first 설정
  # 2:- = 두번쨰 인자가 없을경우, 기본 값은 공백("") 설정
  local localVarOne="${1:-first}"
  local localVarTwo="${2:-}"

  # Case Statement
  case "$localVarOne" in
    first)
      echo "First"
      ;;
    second)
      echo "Second"
      ;;
    third)
      echo "Third"
      ;;
    *)
      echo "Default"
      ;;
  esac

  # if statement
  # -z = empty
  # -n = not empty
  # if [ -z "$localVarTwo" ]; then 와 아래의 구문이 같음
  # else if 의 경우 elif 사용 후 [] 안에 조건문 작성 then 은 생략 가능
  if [ "$localVarTwo" = "" ]; then
    echo "localVarTwo is empty"
  else
    echo "localVarTwo is not empty"
  fi
}

# call func
firstFunc "first" "second"

