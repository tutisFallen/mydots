#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/common.sh" "$@"

log "Refreshing dnf metadata..."
sudo dnf -y makecache

map_pkg() {
  case "$1" in
    ffmpeg) echo "ffmpeg-free" ;;
    *) echo "$1" ;;
  esac
}

install_group() {
  local name="$1"; shift
  local pkgs=("$@")
  log "Installing group: $name"
  for p in "${pkgs[@]}"; do
    p="$(map_pkg "$p")"
    install_pkg_if_available "dnf info" "sudo dnf install -y" "$p"
  done
}

BASE=(xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland pipewire wireplumber wl-clipboard libnotify)
HYPR=(hyprland kitty foot grim slurp swappy)
YAZI=(yazi jq fd-find ripgrep bat fzf zoxide p7zip ffmpeg)
DESKTOP=(playerctl brightnessctl pavucontrol NetworkManager network-manager-applet bluez bluez-tools blueman firefox nautilus thunar fastfetch)

ask_yes_no "Install BASE group?" Y && install_group "base" "${BASE[@]}"
ask_yes_no "Install HYPR group?" Y && install_group "hypr" "${HYPR[@]}"
ask_yes_no "Install YAZI group?" Y && install_group "yazi" "${YAZI[@]}"
ask_yes_no "Install DESKTOP extras group?" N && install_group "desktop" "${DESKTOP[@]}"

if ask_yes_no "Install DMS via COPR (avengemedia/dms)?" Y; then
  sudo dnf -y copr enable avengemedia/dms || warn "Could not enable COPR"
  for p in dms cliphist; do
    install_pkg_if_available "dnf info" "sudo dnf install -y" "$p"
  done
fi

have yazi || warn "Yazi fallback: https://yazi-rs.github.io/docs/installation/"
have hyprland || warn "Hyprland fallback: https://wiki.hypr.land/Getting-Started/Installation/"

log "Fedora install finished."
