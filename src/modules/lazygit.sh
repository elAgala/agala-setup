#!/bin/bash

set -euo pipefail

install_lazygit() {
  echo "Installing lazygit..."

  local download_dir="/tmp/lazygit-install"
  local install_dir="/opt/lazygit"

  if command -v lazygit &>/dev/null; then
    echo "lazygit is already installed"
    return 0
  fi

  mkdir -p "$download_dir"
  cd "$download_dir"

  echo "Downloading and installing lazygit..."
  curl -fLO https://github.com/jesseduffield/lazygit/releases/download/v0.54.2/lazygit_0.54.2_linux_x86_64.tar.gz

  sudo mkdir -p "$install_dir"
  sudo tar -C "$install_dir" -xzf lazygit_0.54.2_linux_x86_64.tar.gz

  rm -rf "$download_dir"

  echo "lazygit installed to /opt/lazygit"
}

install_lazygit
