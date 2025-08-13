#!/bin/bash

set -euo pipefail

install_nvim_dependencies() {
  echo "Installing Neovim dependencies..."

  # Install basic requirements
  sudo dnf install -y curl tar
  sudo dnf install xclip

  # Install nvim config dependencies
  echo "Installing fzf, ripgrep, fd-find, and C compiler..."
  sudo dnf install -y fzf ripgrep fd-find

  # Install C compiler and build tools for nvim-treesitter
  sudo dnf install -y gcc gcc-c++ make

  echo "Dependencies installed successfully"
}

download_and_install_nvim() {
  echo "Downloading Neovim prebuilt archive..."

  local download_dir="/tmp/nvim-install"
  local install_dir="/opt"
  local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"

  # Create temporary download directory
  mkdir -p "$download_dir"
  cd "$download_dir"

  # Download the latest stable release
  curl -LO "$nvim_url"

  # Extract to /opt
  sudo tar -C "$install_dir" -xzf nvim-linux-x86_64.tar.gz

  # Clean up
  rm -rf "$download_dir"

  echo "Neovim extracted to /opt/nvim-linux-x86_64"
  echo "Binary available at /opt/nvim-linux-x86_64/bin/nvim"
}

setup_nvim_config() {
  echo "Setting up Neovim configuration..."

  # Change to home directory to ensure we're in a stable location
  cd "$HOME"

  local config_dir="$HOME/.config/nvim"

  # Create .config directory if it doesn't exist
  mkdir -p "$HOME/.config"

  # Check if config directory already exists
  if [ -d "$config_dir" ]; then
    echo "Neovim config directory already exists at $config_dir"
    echo "Skipping config clone to avoid overwriting existing configuration"
    return 0
  fi

  # Clone the nvim config repository
  echo "Cloning nvim configuration from elAgala/nvim_config..."
  git clone https://github.com/elAgala/nvim_config.git "$config_dir"

  echo "Neovim configuration cloned successfully to $config_dir"
}

install_nvim() {
  echo "Installing Neovim..."

  # Check if nvim is already installed
  if command -v nvim &>/dev/null; then
    echo "Neovim is already installed"
    echo "Current version: $(nvim --version | head -n1)"
    setup_nvim_config
    return 0
  fi

  # Install dependencies
  install_nvim_dependencies

  # Download and install Neovim prebuilt archive
  download_and_install_nvim

  # Setup nvim config
  setup_nvim_config

  echo "Neovim installation complete!"
}

install_nvim
