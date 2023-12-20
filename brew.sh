#!/usr/bin/env bash
#  Filename: brew.sh
#      Desc: TODO (some description)
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself
if [ "$(uname -s)" = 'Darwin' ]; then
  # 允许任何来源否则 cask 安装的软件打不开
  sudo spctl --master-disable
  # Homebrew

  if ! xcode-select --print-path &> /dev/null; then
    xcode-select --install &> /dev/null
  fi

  [ -z "$(which brew)" ] &&
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Updating homebrew"
  # brew tap caskroom/cask
  # http://www.nyx.net/~mlu/pages/computing/installing_and_configuring/installing_and_configuring_command-line_utilities/
  # brew install coreutils
  brew install uutils-coreutils
  brew install grep
  brew install gnu-sed
  brew install tree pv

  # brew install rlwrap
  brew install zsh brew-cask-completion \
  brew install lsd
  brew install tree
  brew install dust
  brew install ncdu
  brew install bat
  brew install delta
  brew install fd
  brew install fzf
  brew install zoxide
  brew install ag
  brew install ripgrep
  brew install cscope
  brew install jq
  brew install jid
  brew install hyperfine
  brew install reattach-to-user-namespace
  brew install git
  brew install git-lfs
  brew install gitui
  brew install tig
  brew install cloc
  brew install graphviz
  brew install imagemagick
  brew install ffmpeg
  brew install gnupg
  brew install highlight
  brew install p7zip
  brew install unar
  brew install ranger
  brew install htop
  brew install bottom
  brew install procs
  brew install iproute2mac
  brew install wget
  brew install xh
  brew install youtube-dl
  brew install subnetcalc
  brew install telnet
  brew install netcat
  brew install socat
  brew install nmap
  brew install proxychains-ng
  brew install shellcheck
  brew install ruby

  # brew install vim # /usr/local/bin/vim

  # $(brew --prefix)/opt/fzf/install
  # brew install mycli python pyenv flake8 go node yarn
  # brew install macvim # And add alias vim='mvim -v' to ~/.bashrc
  # brew install maven ant fish sbt cmus liboauth exiftool doxygen leiningen

  # brew install gnuplot --with-qt --with-cairo

  # nutstore 手动
  brew install --cask hammerspoon
  brew install --cask bob
  # brew install --cask itsycal
  # brew install --cask stats
  brew install --cask dozer
  brew install --cask cheatsheet
  brew install --cask tencent-lemon

  brew install --cask iterm2
  brew install --cask wezterm

  brew install --cask keycastr

  brew install --cask visual-studio-code
  brew install --cask sublime-text
  brew install --cask obsidian
  brew install --cask picgo

  brew install --cask skim

  # brew install --cask switchresx

  brew install --cask vnc-viewer
  brew install --cask microsoft-remote-desktop
  brew install --cask iina
  brew install --cask qqmusic
  # brew install --cask neteasemusic
  brew install --cask google-chrome
  brew install --cask microsoft-edge
  brew install --cask dingtalk
  brew install --cask wireshark
  brew install --cask tunnelblick
  brew install --cask clashx
  # brew install --cask v2rayx
  # brew install --cask macpass
  brew install --cask keepassxc
  brew install --cask snipaste
  brew install --cask sequel-pro
  brew install --cask alt-tab

  # brew tap homebrew/cask-versions

  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  # brew install --cask qlmarkdown quicklook-json appcleaner
  # brew install --cask kawa # A macOS input source switcher with user-defined shortcuts.
  # brew install docker
  # switchkey automute
  brew install --cask vmware-fusion
  # brew install virtualbox virtualbox-extension-pack vagrant
  # brew install google-backup-and-sync postman tor-browser
  # brew install wiznote
  # brew install remoteviewer # spice client
  # brew install aerial # 屏保
  # brew java mat visualvm fluid caffeine xquartz inkscape xbar
  # brew install alfred totalfinder
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags

  # brew tap jeffreywildman/homebrew-virt-manager
  # brew install virt-manager virt-viewer

  # Patched version of tmux
  # brew tap waltarix/homebrew-customs
  # brew install waltarix/homebrew-customs/tmux

  # Create
  gem install gem-ctags
  gem ctags
fi

# brew install homebrew/services

# 下载 https://github.com/shadowsocks/ShadowsocksX-NG/releases
# brew install proxychains-ng
# /usr/local/etc/proxychains.conf
# [ProxyList]
# socks5 127.0.0.1 1081
# proxychains4 curl -L canihazip.com/s
# brew install privoxy
# /usr/local/etc/privoxy/config
# sudo brew services list
# sudo brew services start privoxy

# Dozer https://www.jishuwen.com/d/2dRL
