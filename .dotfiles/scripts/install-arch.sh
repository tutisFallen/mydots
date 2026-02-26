#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/common.sh"

PKGS_FILE="$HOME/.dotfiles/packages/arch.txt"
[[ -f "$PKGS_FILE" ]] || { err "Missing $PKGS_FILE"; exit 1; }

log "Installing Arch package baseline..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm $(pkg_list_clean "$PKGS_FILE")

if have paru; then
  log "AUR helper detected (paru). Ensuring AUR packages for your setup..."
  paru -S --needed --noconfirm dms-shell-git grimblast-git || warn "AUR package install failed; check manually"
else
  warn "paru not found. Install AUR packages manually: dms-shell-git grimblast-git"
fi

log "Arch install done."
