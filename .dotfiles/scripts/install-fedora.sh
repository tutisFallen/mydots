#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/common.sh"

PKGS_FILE="$HOME/.dotfiles/packages/fedora.txt"
[[ -f "$PKGS_FILE" ]] || { err "Missing $PKGS_FILE"; exit 1; }

log "Refreshing metadata..."
sudo dnf -y makecache

log "Installing Fedora baseline packages..."
# map package names/fallbacks
TMP="$(mktemp)"
while read -r p; do
  [[ -z "$p" || "$p" =~ ^# ]] && continue
  case "$p" in
    ffmpeg) echo "ffmpeg-free" >> "$TMP" ;;
    *) echo "$p" >> "$TMP" ;;
  esac
done < "$PKGS_FILE"

sudo dnf install -y $(tr '\n' ' ' < "$TMP") || warn "Some packages unavailable in current repos"
rm -f "$TMP"

log "Enabling DMS COPR (stable) and installing DMS stack..."
sudo dnf -y copr enable avengemedia/dms || warn "Could not enable COPR avengemedia/dms"
sudo dnf install -y dms cliphist || warn "dms/cliphist not installed from COPR"

if ! have yazi; then
  warn "yazi not found in repos. Install via official binary/cargo: https://yazi-rs.github.io/docs/installation/"
fi
if ! have hyprland; then
  warn "hyprland not found in current repos. Follow official: https://wiki.hypr.land/Getting-Started/Installation/"
fi

log "Fedora install finished."
