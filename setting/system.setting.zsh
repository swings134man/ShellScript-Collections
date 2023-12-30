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

asksure() {
  local message="${1:-}"
  echo -n "$message (Y/N)? "
  while read answer; do
    if [[ $answer = [YyNn] ]]; then
      [[ $answer = [Yy] ]] && rtn=0
      [[ $answer = [Nn] ]] && rtn=1
      break
    fi
  done

return $rtn
}

() {
  logger "info" "Setting macOS system ..."
  
  ## Dock & Menu Bar > Automatically hide and show the Dock (enable)
  logger "info" "✅ [Dock] Automatically hide and show the Dock"
  defaults write com.apple.dock autohide -bool true

  ## Mission Control > Automatically rearrange Spaces based on most recent use (disable)
  logger "info" "✅ [Mission Control] Disable Automatically rearrange Spaces based on most recent use"
  defaults write com.apple.dock mru-spaces -bool false

  ## Keyboard > Text > Correct spelling automatically (disable)
  logger "info" "✅ [Keyboard] Disable correct spelling automatically"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  ## Keyboard > Text > Capitalize words automatically (disable)
  logger "info" "✅ [Keyboard] Disable capitalize words automatically"
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  ## Keyboard > Text > Add period with double-space (disable)
  logger "info" "✅ [Keyboard] Disable add period with double-space"
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  ## Keyboard > Text > Use smart quotes and dashes (disable)
  logger "info" "✅ [Keyboard] Disable use smart quotes and dashes"
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  ## Keyboard > Shortcut > Use keyboard navigation to move focus between controls (enable)
  logger "info" "✅ [Keyboard] Use keyboard navigation to move focus between controls"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  ## Trackpad > Point & Click > Tab to click (enable)
  logger "info" "✅ [Trackpad] Enable tab to click"
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  # Enable tap at login as well
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  logger "info" "Setting finder ..."

  # New Finder windows show (set home)
  logger "info" "✅ [Finder] Set New Finder windows show - Home"
  defaults write com.apple.finder NewWindowTarget -string 'PfHm'
  defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

  # Show all filename extensions (enable)
  logger "info" "✅ [Finder] Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Show Path Bar (enable)
  logger "info" "✅ [Finder] Show Path Bar"
  defaults write com.apple.finder ShowPathbar -bool true

  sleep 2

  logger "info" "install HomeBrew"
  
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/${USER}/.zprofile

  logger "info" "✅ [git] install git-lfs"
  brew install git git-lfs

  logger "info" "⏩️ [git] setting git global properties..."
  logger "info" "⏩️ [git] user name:"
  while read name; do
    git config --global user.name $name
  done

  logger "info" "⏩️ [git] user email:"
  while read email; do
    git config --global user.email $email
  done

  git config --global core.precomposeunicode true
  git config --global core.quotepath false

  sleep 1

  if asksure "❔ Would you like to install OpenInTerminal?"; then
      logger "info" "✅ [OpenInTerminal] install OpenInTerminal"

      brew install --cask openinterminal
  fi

  installed_plugin=true;
  installed_theme=true;

  if asksure "❔ Would you like to install oh-my-zsh?"; then
    logger "info" "✅ [oh-my-zsh] install oh-my-zsh."
    logger "warning" "✅ [oh-my-zsh] type \"exit\" after oh-my-zsh installed."
    sleep 2
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    if asksure "❔ Would you like to add recommended plugins? [zsh-syntax-highlighting, zsh-autosuggestions]"; then
      # zsh-syntax-highlighting
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

      # zsh-autosuggestions
      git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    else installed_plugin=false
    fi

    if asksure "❔ Would you like to add custom oh-my-zsh theme? [Powerlevel10k]"; then
      logger "info" "✅ [Powerlevel10k] install Powerlevel10k"
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    else installed_theme=false
    fi

    sleep 1
  fi

  if [ "$installed_plugin" = true ] || [ "$installed_theme" = true ]; then
cat > ${HOME}/setting.README.txt <<EOL
** 모든 설정이 끝난 후 source ~/.zshrc command 를 통해 변경사항을 업데이트할 수 있으나 앞서 mac system 설정을 변경하였으므로 mac 을 재시작 해주세요. **

vi 편집기를 통하여 .zshrc 파일을 엽니다.
vi ~/.zshrc

EOL

    if [ "$installed_plugin" = true ]; then
cat > ${HOME}/setting.README.txt <<EOL
추가한 플러그인 zsh-syntax-highlighting, zsh-autosuggestions 적용을 위해 다음의 동작을 수행합니다.
1. '/' command 를 통하여 검색을 시도하며 plugins 를 검색합니다.
2. 검색 결과가 존재한다면 띄어쓰기 혹은 줄바꿈을 통해 구분하여 zsh-syntax-highlighting zsh-autosuggestions 를 추가해줍니다.
3. 존재하지 않는다면 다음의 설정을 붙여넣어주세요.
plugins=(
        git
        zsh-syntax-highlighting
        zsh-autosuggestions
)

EOL
    fi
    if [ "$installed_theme" = true ]; then
cat > ${HOME}/setting.README.txt <<EOL
Powerlevel10k 테마 적용을 위해 다음의 동작을 수행합니다.
1. '/' command 를 통하여 검색을 시도하며 ZSH_THEME 를 검색합니다.
2. 검색 결과가 존재한다면 ZSH_THEME= 의 값을 "powerlevel10k/powerlevel10k" 로 바꿔주세요.
3. 존재하지 않는다면 다음의 설정을 붙여넣어주세요.
ZSH_THEME="powerlevel10k/powerlevel10k"
EOL
    fi

open "${HOME}/setting.README.txt"
  else logger "success" "✅ please restart your mac!"
  fi
}


