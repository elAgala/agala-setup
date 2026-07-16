#!/bin/bash

set -euo pipefail

install_kitty_packages() {
  echo "Installing Kitty and JetBrains Mono..."
  sudo dnf install -y kitty jetbrains-mono-fonts-all
  echo "Kitty packages installed successfully"
}

setup_kitty_config() {
  echo "Setting up Kitty configuration..."

  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local source_dir="$script_dir/../assets/kitty"
  local target_dir="$HOME/.config/kitty"

  mkdir -p "$target_dir"

  local config_file
  for config_file in kitty.conf ayu.conf; do
    if [ ! -f "$source_dir/$config_file" ]; then
      echo "Warning: Kitty asset not found at $source_dir/$config_file"
      continue
    fi

    if [ -f "$target_dir/$config_file" ]; then
      echo "Kitty config already exists at $target_dir/$config_file"
      echo "Skipping it to avoid overwriting existing configuration"
      continue
    fi

    cp "$source_dir/$config_file" "$target_dir/$config_file"
    echo "Copied Kitty config to $target_dir/$config_file"
  done
}

install_kitty() {
  echo "Installing Kitty..."

  install_kitty_packages
  setup_kitty_config

  echo "Kitty installation complete!"
}

install_kitty
