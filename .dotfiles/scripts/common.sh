#!/usr/bin/env bash
set -euo pipefail

log() { printf '\033[1;34m[dotfiles]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }
err() { printf '\033[1;31m[err]\033[0m %s\n' "$*"; }

have() { command -v "$1" >/dev/null 2>&1; }

detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    echo "${ID:-unknown}"
  else
    echo unknown
  fi
}

pkg_list_clean() {
  grep -vE '^\s*#|^\s*$' "$1" | tr '\n' ' '
}
