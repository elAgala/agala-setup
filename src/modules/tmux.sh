#!/bin/bash

set -euo pipefail

install_tmux_package() {
  echo "Installing tmux via dnf..."

  if command -v tmux &>/dev/null; then
    echo "tmux is already installed"
    echo "Current version: $(tmux -V)"
    return 0
  fi

  sudo dnf install -y tmux
  echo "tmux installed successfully"
}

setup_tmux_config() {
  echo "Setting up tmux configuration..."

  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local source_config="$script_dir/../assets/.tmux.conf"
  local target_config="$HOME/.tmux.conf"

  if [ ! -f "$source_config" ]; then
    echo "Warning: tmux config not found at $source_config"
    echo "tmux will use its default configuration"
    return 0
  fi

  if [ -f "$target_config" ]; then
    echo "tmux config already exists at $target_config"
    echo "Skipping it to avoid overwriting existing configuration"
    return 0
  fi

  cp "$source_config" "$target_config"
  echo "tmux configuration copied successfully to $target_config"
}

install_tmux() {
  echo "Installing tmux..."

  install_tmux_package
  setup_tmux_config

  echo "tmux installation complete!"
}

install_tmux
