#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/common.sh" "$@"

log "Updating apt metadata..."
sudo apt-get update -y

install_group() {
  local name="$1"; shift
  local pkgs=("$@")
  log "Installing group: $name"
  for p in "${pkgs[@]}"; do
    install_pkg_if_available "apt-cache show" "sudo apt-get install -y" "$p"
  done
}

BASE=(xdg-desktop-portal xdg-desktop-portal-gtk pipewire wireplumber wl-clipboard libnotify-bin)
HYPR=(hyprland xdg-desktop-portal-hyprland kitty foot grim slurp swappy)
YAZI=(yazi jq fd-find ripgrep bat fzf zoxide p7zip-full ffmpeg)
DESKTOP=(playerctl brightnessctl pavucontrol policykit-1 network-manager-gnome bluez blueman firefox nautilus thunar fastfetch)

ask_yes_no "Install BASE group?" Y && install_group "base" "${BASE[@]}"
ask_yes_no "Install HYPR group?" Y && install_group "hypr" "${HYPR[@]}"
ask_yes_no "Install YAZI group?" Y && install_group "yazi" "${YAZI[@]}"
ask_yes_no "Install DESKTOP extras group?" N && install_group "desktop" "${DESKTOP[@]}"

if ask_yes_no "Show/install DMS note? (Ubuntu uses upstream repos)" Y; then
  warn "DMS docs: https://danklinux.com/docs/dankmaterialshell/installation/"
fi

have fastfetch || warn "Fastfetch fallback: https://github.com/fastfetch-cli/fastfetch"
have swappy || warn "Swappy reference: https://launchpad.net/ubuntu/+source/swappy"
have yazi || warn "Yazi fallback: https://yazi-rs.github.io/docs/installation/"
have hyprland || warn "Hyprland fallback: https://wiki.hypr.land/Getting-Started/Installation/"

log "Ubuntu install finished."
