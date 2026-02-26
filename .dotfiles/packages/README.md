# Package baseline for this dotfiles setup

These lists were generated from your current Arch setup + config references (`hypr`, `yazi`, `dms`).

## What is required vs optional

- **Required for session**: hyprland, xdg portals, terminal, yazi, pipewire/wireplumber, wl-clipboard, notification stack.
- **Required for your keybinds**: dms-shell, grim/slurp/swappy, tesseract, cliphist, playerctl, brightnessctl.
- **Optional**: firefox, nautilus/thunar, fastfetch.

## Cross-distro reality

Some pieces are Arch/AUR specific:
- `dms-shell-git`
- `grimblast-git`

On Ubuntu/Fedora, keep the same dotfiles, but install these manually from upstream (or replace related keybinds with distro-available tools).

## Quick install examples

Fedora:
```bash
sudo dnf install $(grep -vE '^#|^$' ~/.dotfiles/packages/fedora.txt)
```

Ubuntu:
```bash
sudo apt update
sudo apt install -y $(grep -vE '^#|^$' ~/.dotfiles/packages/ubuntu.txt)
```

Arch:
```bash
sudo pacman -S --needed $(grep -vE '^#|^$' ~/.dotfiles/packages/arch.txt)
```
