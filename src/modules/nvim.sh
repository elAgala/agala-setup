#!/bin/bash

set -euo pipefail

install_nvim_dependencies() {
  echo "Installing Neovim dependencies..."

  # Install xclip for copy/pasting from nvim + LazyNvim requirements
  echo "Installing fzf, xclip, ripgrep, fd-find, and C compiler..."
  sudo dnf install -y xclip fzf ripgrep fd-find
  sudo dnf install -y gcc gcc-c++ make
  echo "Dependencies installed successfully"
}

download_and_install_nvim() {
  echo "Downloading Neovim prebuilt archive..."

  local download_dir="/tmp/nvim-install"
  local install_dir="/opt/nvim"
  local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"

  mkdir -p "$download_dir"
  cd "$download_dir"

  curl -fLO "$nvim_url"

  sudo mkdir -p "$install_dir"
  sudo tar -C "$install_dir" --strip-components=1 -xzf nvim-linux-x86_64.tar.gz

  rm -rf "$download_dir"
  echo "Neovim extracted to /opt/nvim"
}

setup_nvim_config() {
  echo "Setting up Neovim configuration..."

  cd "$HOME"

  local config_dir="$HOME/.config/nvim"

  mkdir -p "$HOME/.config"

  if [ -d "$config_dir" ]; then
    echo "Neovim config directory already exists at $config_dir"
    echo "Skipping config clone to avoid overwriting existing configuration"
    return 0
  fi

  echo "Cloning nvim configuration from elAgala/nvim_config..."
  git clone https://github.com/elAgala/nvim_config.git "$config_dir"

  echo "Neovim configuration cloned successfully to $config_dir"
}

install_nvim() {
  echo "Installing Neovim..."

  if command -v nvim &>/dev/null; then
    echo "Neovim is already installed"
    echo "Current version: $(nvim --version | head -n1)"
    setup_nvim_config
    return 0
  fi

  install_nvim_dependencies
  download_and_install_nvim
  setup_nvim_config

  echo "Neovim installation complete!"
}

install_nvim
