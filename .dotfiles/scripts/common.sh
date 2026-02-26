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

NON_INTERACTIVE=0
for arg in "$@"; do
  [[ "$arg" == "--yes" || "$arg" == "-y" ]] && NON_INTERACTIVE=1
done

ask_yes_no() {
  local q="$1"
  local default="${2:-Y}" # Y|N
  if [[ "$NON_INTERACTIVE" -eq 1 ]]; then
    [[ "$default" == "Y" ]]
    return
  fi

  local prompt="[y/N]"
  [[ "$default" == "Y" ]] && prompt="[Y/n]"
  read -r -p "$q $prompt " ans
  ans="${ans:-$default}"
  [[ "$ans" =~ ^[Yy]$ ]]
}

# Usage: install_pkg_if_available <check_cmd> <install_cmd> <pkg>
install_pkg_if_available() {
  local check_cmd="$1" install_cmd="$2" pkg="$3"
  if eval "$check_cmd \"$pkg\" >/dev/null 2>&1"; then
    if eval "$install_cmd \"$pkg\""; then
      echo "OK   $pkg"
    else
      echo "FAIL $pkg"
    fi
  else
    echo "MISS $pkg"
  fi
}
