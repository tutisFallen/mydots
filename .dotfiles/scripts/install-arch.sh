#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/common.sh" "$@"

log "Refreshing pacman db..."
sudo pacman -Syu --noconfirm

install_group() {
  local name="$1"; shift
  local pkgs=("$@")
  log "Installing group: $name"
  for p in "${pkgs[@]}"; do
    if pacman -Si "$p" >/dev/null 2>&1; then
      if sudo pacman -S --needed --noconfirm "$p"; then
        echo "OK   $p"
      else
        echo "FAIL $p"
      fi
    else
      echo "MISS $p"
    fi
  done
}

BASE=(xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland pipewire wireplumber wl-clipboard libnotify)
HYPR=(hyprland kitty foot grim slurp swappy)
YAZI=(yazi jq fd ripgrep bat fzf zoxide p7zip ffmpeg)
DESKTOP=(playerctl brightnessctl pavucontrol polkit-kde-agent network-manager-applet bluez bluez-utils blueman firefox nautilus thunar fastfetch)

ask_yes_no "Install BASE group?" Y && install_group "base" "${BASE[@]}"
ask_yes_no "Install HYPR group?" Y && install_group "hypr" "${HYPR[@]}"
ask_yes_no "Install YAZI group?" Y && install_group "yazi" "${YAZI[@]}"
ask_yes_no "Install DESKTOP extras group?" N && install_group "desktop" "${DESKTOP[@]}"

if ask_yes_no "Install AUR helpers packages (dms-shell-git, grimblast-git)?" Y; then
  if have paru; then
    for p in dms-shell-git grimblast-git; do
      if paru -Si "$p" >/dev/null 2>&1; then
        paru -S --needed --noconfirm "$p" && echo "OK   $p" || echo "FAIL $p"
      else
        echo "MISS $p"
      fi
    done
  else
    warn "paru not found. Install manually: dms-shell-git grimblast-git"
  fi
fi

log "Arch install finished."
