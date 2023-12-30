#!/usr/bin/env zsh

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

() {
logger "info" "generate ssh key"
ssh-keygen

logger "info" "make directories"
mkdir ${HOME}/1.project
logger "success" "✅ project folder was created in path ${HOME}/1.project"

mkdir ${HOME}/2.tools
logger "success" "✅ project folder was created in path ${HOME}/2.tools"
mkdir ${HOME}/2.tools/maven
cat <<EOF >${HOME}/2.tools/maven/maven.txt
maven download url (recommand verion - 3.6.3)
https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/

1. intellij 특정 버전 maven 필요시.
  - 필요한 메이븐 버전을 다운받아 intellij Settings > Build, Execution, Deployment > Build Tools > Maven > Maven home path 에 경로를 설정하여 사용합니다.
2. 별도 설정 없이 command를 사용하고싶은 경우.
  - 최신 버전을 brew 를 통해 다운받아 사용할수도 있습니다. (프로젝트 호환에 유의하세요.) "brew install mvn"
3. 특정 버전을 환경변수 설정을 통하여 사용시.
  - ~/.zshrc 파일에 다음과 같이 경로 설정을 해줍니다.
export M2_HOME="\$HOME/{메이븐 설치 경로}"
export PATH="\$M2_HOME/bin:\$PATH"
EOF

mkdir ${HOME}/2.tools/tomcat
cat <<EOF >${HOME}/2.tools/tomcat/tomcat.txt
tomcat download url (recommand verion - 9)
https://tomcat.apache.org/download-90.cgi

필요한 버전을 다운받아 설치합니다.
EOF

logger "info" "✅ install nvm (node package manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

logger "info" "✅ install jenv (Java environment manager)"
brew install jenv
jenv enable-plugin export
exec $SHELL -l

readmeFilePath="${HOME}/develop.README.txt"
cat <<EOF >$readmeFilePath
*생성 파일 내역
  - ~/1.project - 프로젝트 저장용도
  - ~/2.tools   - 개발도구 저장용도
    - /maven    - 메이븐 저장용도
    - /tomcat   - 톰켓 저장용도

*설치 도구 내역
  - nvm         - node version manager
  - jenv        - java environment manager

1. maven
~/2.tools/maven 폴더로 이동하여 maven.txt 파일 참조.

2. tomcat
~/2.tools/tomcat 폴더로 이동하여 tomcat.txt 파일 참조.

3. nvm
node js 설치/관리 도구입니다.
여러 버전의 node js 를 설치하거나 설정을 통한 사용을 도와줍니다.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
명령어를 통하여 설치되었으며 'nvm doctor' 명령어를 통해 설치상태를 검사할 수 있습니다.
필요한 node version을 'nvm install {version}' 명령어를 통해 설치할 수 있으머 --lts 옵션을 통하여 lts 버전을 설치할 수 있습니다.
ex) 16 lts 버전 다운로드: nvm install 16 --lts
12, 14, 16, 18 각각의 lts 버전을 다운로드하여 프로젝트에 맞게 사용합니다.
nvm에 대한 더 자세한 설명은 https://github.com/nvm-sh/nvm 공식문서를 참고하세요.

4. jenv
java 환경설정 도구입니다.
여러 버전의 JDK 를 설치하여 사용할때 환경설정을 도와줍니다.
brew install jenv
명령어를 통하여 설치되었으며 'jenv doctor' 명령어를 통해 설치상태를 검사할 수 있습니다.
brew 혹은 인터넷을 통하여 jdk 를 설치한 뒤 'jenv add {jdk 경로}' 명령어로 jenv에 추가할 수 있습니다.
'jenv versions' 명령어로 설치된 목록을 확인할 수 있으며, 사용할 버전을 'jenv local {version}' 명령어로 설정할 수 있습니다.
m1 혹은 m2 를 사용중이라면 arm64 hardware와 호환되는 jdk를 설치하여 사용합니다.
8, 11, 17 각각의 lts 버전을 다운로드하여 등록해두면 좋습니다.
jenv에 대한 더 자세한 설명은 https://github.com/jenv/jenv 공식문서를 참고하세요.

EOF

open "$readmeFilePath"
}
