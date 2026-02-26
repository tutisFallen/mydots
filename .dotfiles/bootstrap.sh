#!/usr/bin/env bash
set -euo pipefail

# Dotfiles bare-repo bootstrap (Atlassian style)
git clone --bare "$1" "$HOME/.cfg"
function dotfiles {
  /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}
mkdir -p "$HOME/.dotfiles-backup"
dotfiles checkout || {
  echo "Backing up pre-existing files to ~/.dotfiles-backup ..."
  dotfiles checkout 2>&1 | egrep "\s+\." | awk '{print $1}' | while read -r file; do
    mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
    mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
  done
  dotfiles checkout
}
dotfiles config status.showUntrackedFiles no
echo "Dotfiles restored."
