#!/usr/bin/env bash
#  Filename: brew.sh
#      Desc: 跨平台工具安装脚本
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself
#
# 用法: ./brew.sh [选项]
#   -n, --dry-run   预览变更，不实际执行
#   -v, --verbose   显示详细输出
#   -h, --help      显示帮助信息
#
# 注意: 需要 Bash 4+（macOS 请通过 brew install bash 安装）

set -euo pipefail

DRY_RUN=${DRY_RUN:-false}
VERBOSE=${VERBOSE:-false}

# ============================================================
# 日志函数（与 install.sh 风格一致）
# ============================================================

log_info()  { echo -e " \033[1;32m✔\033[0m  $1"; }
log_warn()  { echo -e " \033[1;33m!\033[0m  $1"; }
log_skip()  { echo -e " \033[1;36m→\033[0m  $1"; }
log_error() { echo -e " \033[1;31m✘\033[0m  $1" >&2; }
log_debug() { [[ "$VERBOSE" == "true" ]] && echo -e " \033[1;90mdebug:\033[0m  $1" || true; }
log_section() { echo -e "\n\033[1;34m▶ $1\033[0m"; }

# --- OS / 包管理器检测 ---

detect_os() {
  local uname_out
  uname_out="$(uname -s)"
  case "$uname_out" in
    Darwin*)  echo "darwin" ;;
    Linux*)   echo "linux" ;;
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    *)        echo "unknown"; log_error "不支持的操作系统: $uname_out"; exit 1 ;;
  esac
}

detect_pkg_mgr() {
  local os="$1"
  if [[ "$os" == "darwin" ]]; then
    echo "brew"
  elif [[ "$os" == "windows" ]]; then
    echo "scoop"
  elif [[ "$os" == "linux" ]]; then
    if command -v apt-get &>/dev/null; then
      echo "apt"
    elif command -v dnf &>/dev/null; then
      echo "dnf"
    elif command -v pacman &>/dev/null; then
      echo "pacman"
    elif command -v zypper &>/dev/null; then
      echo "zypper"
    else
      echo "unknown"
    fi
  fi
}

# --- 包管理器安装 ---

ensure_brew() {
  if ! command -v brew &>/dev/null; then
    log_info "安装 Homebrew..."
    [[ "$DRY_RUN" == "true" ]] && return
    if ! xcode-select --print-path &>/dev/null; then
      xcode-select --install &>/dev/null
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  log_skip "Homebrew 已安装"
}

ensure_scoop() {
  if ! command -v scoop &>/dev/null; then
    log_info "安装 Scoop..."
    [[ "$DRY_RUN" == "true" ]] && return
    powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; irm get.scoop.sh | iex"
  fi
  log_skip "Scoop 已安装"
  # 添加常用 buckets
  for bucket in extras versions nonportable nerd-fonts; do
    if ! scoop bucket list 2>/dev/null | grep -q "$bucket"; then
      log_info "添加 Scoop bucket: $bucket"
      [[ "$DRY_RUN" == "true" ]] && continue
      scoop bucket add "$bucket"
    fi
  done
}

ensure_pkg_mgr() {
  case "$PKG_MGR" in
    brew)   ensure_brew ;;
    scoop)  ensure_scoop ;;
    apt)
      log_info "更新 apt..."
      [[ "$DRY_RUN" == "true" ]] && return
      sudo apt-get update -qq
      ;;
    dnf)
      log_info "更新 dnf..."
      [[ "$DRY_RUN" == "true" ]] && return
      sudo dnf check-update -q || true
      ;;
    pacman)
      log_info "更新 pacman..."
      [[ "$DRY_RUN" == "true" ]] && return
      sudo pacman -Sy --noconfirm
      ;;
    zypper)
      log_info "更新 zypper..."
      [[ "$DRY_RUN" == "true" ]] && return
      sudo zypper refresh -q
      ;;
    *)
      log_error "未检测到包管理器"
      exit 1
      ;;
  esac
}

# --- 安装函数 ---

_install_brew() {
  local pkg="$1"
  if brew list "$pkg" &>/dev/null; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    brew install "$pkg"
  fi
}

_install_brew_cask() {
  local pkg="$1"
  if brew list --cask "$pkg" &>/dev/null; then
    log_skip "已安装 (cask): $pkg"
  else
    log_info "安装 (cask): $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    brew install --cask "$pkg"
  fi
}

_install_scoop() {
  local pkg="$1"
  if scoop list "$pkg" &>/dev/null | grep -q "$pkg"; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    scoop install "$pkg"
  fi
}

_install_apt() {
  local pkg="$1"
  if dpkg -s "$pkg" &>/dev/null; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    sudo apt-get install -y -qq "$pkg"
  fi
}

_install_dnf() {
  local pkg="$1"
  if dnf list installed "$pkg" &>/dev/null; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    sudo dnf install -y -q "$pkg"
  fi
}

_install_pacman() {
  local pkg="$1"
  if pacman -Qi "$pkg" &>/dev/null; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    sudo pacman -S --noconfirm --quiet "$pkg"
  fi
}

_install_zypper() {
  local pkg="$1"
  if zypper se -i "$pkg" &>/dev/null | grep -q "^i"; then
    log_skip "已安装: $pkg"
  else
    log_info "安装: $pkg"
    [[ "$DRY_RUN" == "true" ]] && return
    sudo zypper install -y --quiet "$pkg"
  fi
}

_install() {
  local pkg="$1"
  case "${PKG_MGR:-}" in
    brew)   _install_brew "$pkg" ;;
    scoop)  _install_scoop "$pkg" ;;
    apt)    _install_apt "$pkg" ;;
    dnf)    _install_dnf "$pkg" ;;
    pacman) _install_pacman "$pkg" ;;
    zypper) _install_zypper "$pkg" ;;
    *)      log_error "未知包管理器: ${PKG_MGR:-}" ;;
  esac
}

_install_gui() {
  local pkg="$1"
  case "${PKG_MGR:-}" in
    brew)   _install_brew_cask "$pkg" ;;
    scoop)  _install_scoop "$pkg" ;;
    *)      log_debug "GUI 安装不支持: ${PKG_MGR:-}" ;;
  esac
}

# --- macOS 专用 ---

install_macos_only() {
  log_section "macOS 专用工具"

  if [[ "$DRY_RUN" != "true" ]]; then
    sudo spctl --master-disable
  fi

  _install_brew uutils-coreutils
  _install_brew grep
  _install_brew gnu-sed
  _install_brew gnu-tar
  _install_brew zsh
  _install_brew brew-cask-completion
  _install_brew reattach-to-user-namespace
  _install_brew iproute2mac
  _install_brew proxychains-ng
  _install_brew lux
  _install_brew yh
  _install_brew jid
}

# --- CLI 工具 ---

install_cli_tools() {
  log_section "CLI 工具"

  local pkgs

  case "$PKG_MGR" in
    brew)
      pkgs="git git-lfs gnupg p7zip unar tree wget nmap universal-ctags tealdeer ruby tig ncdu htop cscope socat netcat telnet subnetcalc"
      ;;
    scoop)
      pkgs="git git-lfs gnupg 7zip unar tree wget nmap universal-ctags tealdeer ruby"
      ;;
    apt)
      pkgs="git git-lfs gnupg p7zip-full unar tree wget nmap universal-ctags tealdeer ruby tig ncdu htop cscope socat netcat-openbsd telnet"
      ;;
    dnf)
      pkgs="git git-lfs gnupg p7zip unar tree wget nmap ctags tealdeer ruby tig ncdu htop socat nmap-ncat telnet"
      ;;
    pacman)
      pkgs="git git-lfs gnupg p7zip unar tree wget nmap ctags tealdeer ruby tig ncdu htop socat gnu-netcat inetutils"
      ;;
    zypper)
      pkgs="git git-lfs gpg2 p7zip unar tree wget nmap ctags tealdeer ruby tig ncdu htop socat netcat-openbsd telnet"
      ;;
  esac

  for pkg in $pkgs; do
    _install "$pkg"
  done

  if command -v git-lfs &>/dev/null && [[ "$DRY_RUN" != "true" ]]; then
    git lfs install 2>/dev/null || true
  fi
}

# --- GUI 应用 ---

install_gui_apps() {
  log_section "GUI 应用"

  case "$PKG_MGR" in
    brew)
      log_debug "分类: 效率工具"
      for app in raycast hammerspoon karabiner-elements only-switch dozer cheatsheet bob keycastr tencent-lemon alt-tab; do
        _install_gui "$app"
      done

      log_debug "分类: 终端开发"
      for app in ghostty wezterm visual-studio-code sublime-text obsidian; do
        _install_gui "$app"
      done

      log_debug "分类: 办公笔记"
      for app in wpsoffice-cn drawio mubu yixiangbiji; do
        _install_gui "$app"
      done

      log_debug "分类: 云存储"
      for app in baidunetdisk picgo updf; do
        _install_gui "$app"
      done

      log_debug "分类: 远程桌面"
      for app in todesk microsoft-remote-desktop vnc-viewer vmware-fusion orbstack; do
        _install_gui "$app"
      done

      log_debug "分类: 影音"
      for app in iina qqmusic; do
        _install_gui "$app"
      done

      log_debug "分类: 浏览器"
      for app in google-chrome microsoft-edge arc; do
        _install_gui "$app"
      done

      log_debug "分类: 通信"
      for app in dingtalk wechat; do
        _install_gui "$app"
      done

      log_debug "分类: 网络工具"
      for app in wireshark tunnelblick clash-party; do
        _install_gui "$app"
      done

      log_debug "分类: 安全工具"
      for app in keepassxc snipaste sequel-ace; do
        _install_gui "$app"
      done
      ;;

    scoop)
      log_debug "分类: 浏览器"
      for app in googlechrome edge arc; do
        _install_gui "$app"
      done

      log_debug "分类: 终端开发"
      for app in wezterm vscode sublime-text obsidian; do
        _install_gui "$app"
      done

      log_debug "分类: 办公笔记"
      _install_gui drawio

      log_debug "分类: 远程桌面"
      _install_gui anydesk

      log_debug "分类: 安全工具"
      for app in keepassxc wireshark; do
        _install_gui "$app"
      done

      log_debug "分类: 通信"
      for app in wechat dingtalk; do
        _install_gui "$app"
      done
      ;;

    *)
      log_debug "GUI 安装不支持: $PKG_MGR"
      ;;
  esac
}

# --- 字体 ---

install_fonts() {
  log_section "字体"

  case "$PKG_MGR" in
    brew)
      _install_brew_cask font-maple-mono-nf-cn
      ;;
    scoop)
      _install_scoop "Maple-Mono-NF-CN"
      ;;
    apt)
      log_info "安装 Nerd Font (手动: https://github.com/ryanoasis/nerd-fonts/releases)"
      ;;
    *)
      log_debug "字体安装不支持: $PKG_MGR"
      ;;
  esac
}

# --- 收尾 ---

post_install() {
  log_section "收尾工作"

  case "$PKG_MGR" in
    brew)
      if command -v gem &>/dev/null; then
        log_info "安装 gem-ctags..."
        [[ "$DRY_RUN" == "true" ]] && return
        gem install gem-ctags 2>/dev/null || true
        gem ctags 2>/dev/null || true
      fi
      ;;
    scoop)
      log_info "Scoop 清理缓存..."
      [[ "$DRY_RUN" == "true" ]] && return
      scoop cache rm -a 2>/dev/null || true
      ;;
  esac

  echo ''
  log_info "所有工具安装完成！"
}

# --- 主流程 ---

usage() {
  cat << 'EOF'
用法: ./brew.sh [选项]

跨平台工具安装脚本（macOS brew / Windows scoop / Linux apt|dnf|pacman|zypper）

选项:
  -n, --dry-run   预览变更，不实际执行
  -v, --verbose   显示详细输出
  -h, --help      显示帮助信息

示例:
  ./brew.sh              # 正常安装
  ./brew.sh --dry-run    # 预览变更
EOF
  exit 0
}

# 解析参数
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run) DRY_RUN=true; shift ;;
    -v|--verbose) VERBOSE=true; shift ;;
    -h|--help)    usage ;;
    *)            shift ;;
  esac
done

# 检测环境
OS="$(detect_os)"
PKG_MGR="$(detect_pkg_mgr "$OS")"

echo -e "\033[1;37m"
echo "  系统: $OS"
echo "  包管理器: $PKG_MGR"
[[ "$DRY_RUN" == "true" ]] && echo "  模式: 预览 (dry-run)"
echo -e "\033[0m"

# 确保包管理器可用
ensure_pkg_mgr

# macOS 专用工具
if [[ "$OS" == "darwin" ]]; then
  install_macos_only
fi

# 跨平台 CLI 工具
install_cli_tools

# GUI 应用
install_gui_apps

# 字体
install_fonts

# 收尾
post_install
