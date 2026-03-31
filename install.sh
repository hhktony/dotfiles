#!/usr/bin/env bash
#  Filename: install.sh
#   Created: 2013-04-22 23:34:09
#      Desc: Linux Configuration files
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DRY_RUN=${DRY_RUN:-false}
VERBOSE=${VERBOSE:-false}

usage() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -h, --help      Show this help message
  -n, --dry-run   Show what would be done without making changes
  -v, --verbose   Enable verbose output
  -r, --rollback  Rollback symlinks to backup files

Examples:
  $(basename "$0")           # Normal install
  DRY_RUN=true $(basename "$0")  # Preview changes
  $(basename "$0") --rollback  # Restore from backups
EOF
  exit 0
}

log_info()  { echo -e " \033[1;32m✔\033[0m  $1"; }
log_warn()  { echo -e " \033[1;33m!\033[0m  $1"; }
log_skip()  { echo -e " \033[1;36m→\033[0m  $1"; }
log_error() { echo -e " \033[1;31m✘\033[0m  $1" >&2; }
log_debug() { [[ "$VERBOSE" == "true" ]] && echo -e " \033[1;90mdebug:\033[0m  $1"; }

ensure_dirs() {
  log_info "Creating directories..."
  [[ "$DRY_RUN" == "true" ]] && return

  mkdir -p "$HOME/workspace"
  mkdir -p "$HOME/Music"
  mkdir -p "$HOME/software"
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/.mpd/playlists"
  touch "$HOME"/.mpd/{db,log,pid,state,sticker.sql}
}

link_file() {
  local overwrite_all=${overwrite_all:-false}
  local backup_all=${backup_all:-false}
  local skip_all=${skip_all:-false}

  local src=$1 dst=$2

  local overwrite backup skip action

  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ "$(readlink "$dst")" == "$src" ]]; then
      log_skip "Already linked: $dst"
      return
    fi

    if [[ "$overwrite_all" == "false" && "$backup_all" == "false" && "$skip_all" == "false" ]]; then
      log_warn "File already exists: $dst"
      echo "    [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
      read -rsn 1 action
      case "$action" in
        o ) overwrite=true;;
        O ) overwrite_all=true;;
        b ) backup=true;;
        B ) backup_all=true;;
        s ) skip=true;;
        S ) skip_all=true;;
        * ) skip=true;;
      esac
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [[ "$overwrite" == "true" ]]; then
      [[ "$DRY_RUN" == "true" ]] && log_debug "Would remove: $dst" || rm -rf "$dst"
      log_info "Removed: $dst"
    elif [[ "$backup" == "true" ]]; then
      [[ "$DRY_RUN" == "true" ]] && log_debug "Would backup: $dst" || mv "$dst" "${dst}.backup"
      log_info "Backed up: $dst → ${dst}.backup"
    elif [[ "$skip" == "true" ]]; then
      log_skip "Skipped: $src"
      return
    fi
  fi

  if [[ "$skip" != "true" ]]; then
    if [[ "$DRY_RUN" == "true" ]]; then
      log_debug "Would link: $src → $dst"
    else
      ln -s "$src" "$dst" && log_info "Linked: $src → $dst"
    fi
  fi
}

do_link_dir() {
  local src_dir=$1 dst_dir=$2 filter=$3

  [[ "$DRY_RUN" == "true" ]] && log_info "Scanning $src_dir..."

  for src in $(ls "$src_dir" $filter 2>/dev/null); do
    link_file "${src_dir}${src}" "${dst_dir}${src}"
  done
}

rollback() {
  log_info "Rolling back..."

  local count=0
  for f in $(find "$HOME" -maxdepth 3 -type l -lname "$DOTFILES_DIR/*" 2>/dev/null); do
    local backup="${f}.backup"
    if [[ -f "$backup" ]]; then
      [[ "$DRY_RUN" == "true" ]] && log_debug "Would restore: $f" || mv "$backup" "$f"
      log_info "Restored: $f"
      ((count++))
    else
      [[ "$DRY_RUN" == "true" ]] && log_debug "Would remove: $f" || rm -f "$f"
      log_info "Removed symlink: $f"
      ((count++))
    fi
  done

  [[ "$count" -eq 0 ]] && log_warn "No symlinks found to rollback"
}

config_zsh() {
  log_info "Configuring zsh..."

  [[ "$DRY_RUN" == "true" ]] && return

  sed -i "s|ZSH=.*|ZSH=$HOME/.oh-my-zsh|g" "$DOTFILES_DIR"/zshrc

  local oh_zsh_dir="$HOME/.oh-my-zsh"
  if [[ -d "$oh_zsh_dir" ]]; then
    log_skip "oh-my-zsh already installed"
    return
  fi

  git clone -q --depth 1 https://github.com/robbyrussell/oh-my-zsh.git "$oh_zsh_dir"

  local plugins_dir="$oh_zsh_dir/custom/plugins"
  local themes_dir="$oh_zsh_dir/custom/themes"

  git clone -q https://github.com/z-shell/F-Sy-H.git "$plugins_dir"/F-Sy-H
  git clone -q https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir"/zsh-autosuggestions
  git clone -q https://github.com/djui/alias-tips "$plugins_dir"/alias-tips
  curl --create-dirs -fLo "$themes_dir"/hhktony.zsh-theme \
    https://raw.githubusercontent.com/hhktony/hhktony.zsh-theme/master/hhktony.zsh-theme

  log_info "oh-my-zsh installed"
}

main() {
  local overwrite_all=false backup_all=false skip_all=false

  ensure_dirs

  log_info "Linking dotfiles..."
  do_link_dir "$DOTFILES_DIR/" "$HOME/" '-I ssh -I config -I README.md -I install.sh'
  do_link_dir "$DOTFILES_DIR/config/" "$HOME/.config/"

  [[ ! -e ~/.git-prompt.sh ]] && curl -fLo ~/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 2>/dev/null || true

  config_zsh

  echo ''
  log_info "All installed!"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help) usage ;;
    -n|--dry-run) DRY_RUN=true; shift ;;
    -v|--verbose) VERBOSE=true; shift ;;
    -r|--rollback) rollback; exit 0 ;;
    *) shift ;;
  esac
done

main
