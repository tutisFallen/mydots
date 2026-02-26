#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/common.sh"

PKGS_FILE="$HOME/.dotfiles/packages/ubuntu.txt"
[[ -f "$PKGS_FILE" ]] || { err "Missing $PKGS_FILE"; exit 1; }

log "Updating apt metadata..."
sudo apt-get update -y

log "Installing Ubuntu baseline packages..."
TO_INSTALL=()
while read -r p; do
  [[ -z "$p" || "$p" =~ ^# ]] && continue
  if apt-cache show "$p" >/dev/null 2>&1; then
    TO_INSTALL+=("$p")
  else
    warn "Not in apt now: $p"
  fi
done < "$PKGS_FILE"

if ((${#TO_INSTALL[@]})); then
  sudo apt-get install -y "${TO_INSTALL[@]}"
fi

# focused fallbacks based on your links
if ! have fastfetch; then
  warn "fastfetch missing. Use official repo/build: https://github.com/fastfetch-cli/fastfetch"
fi
if ! have swappy; then
  warn "swappy missing. Check Launchpad source/version: https://launchpad.net/ubuntu/+source/swappy"
fi
if ! have yazi; then
  warn "yazi missing. Install from official docs: https://yazi-rs.github.io/docs/installation/"
fi
if ! have hyprland; then
  warn "hyprland missing. Install per official docs: https://wiki.hypr.land/Getting-Started/Installation/"
fi

log "Ubuntu install finished."
