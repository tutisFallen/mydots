#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/common.sh"

OS="$(detect_os)"
log "Detected OS: $OS"
case "$OS" in
  arch|cachyos|manjaro)
    exec "$DIR/install-arch.sh"
    ;;
  fedora)
    exec "$DIR/install-fedora.sh"
    ;;
  ubuntu|debian|linuxmint|pop)
    exec "$DIR/install-ubuntu.sh"
    ;;
  *)
    err "Unsupported distro: $OS"
    echo "Run one of: install-arch.sh, install-fedora.sh, install-ubuntu.sh"
    exit 1
    ;;
esac
