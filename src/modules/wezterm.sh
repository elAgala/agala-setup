#!/bin/bash

set -euo pipefail

enable_wezterm_copr() {
  echo "Enabling WezTerm Copr repository..."

  if dnf copr list enabled | grep -q "wezfurlong/wezterm-nightly"; then
    echo "WezTerm Copr repository is already enabled"
    return 0
  fi

  sudo dnf copr enable wezfurlong/wezterm-nightly -y

  echo "WezTerm Copr repository enabled successfully"
}

install_wezterm_package() {
  echo "Installing WezTerm via dnf..."

  if command -v wezterm &>/dev/null; then
    echo "WezTerm is already installed"
    echo "Current version: $(wezterm --version)"
    return 0
  fi

  sudo dnf install -y wezterm

  echo "WezTerm installed successfully"
}

setup_wezterm_config() {
  echo "Setting up WezTerm configuration..."

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local custom_config="$script_dir/../assets/.wezterm.lua"
  local target_config="$HOME/.wezterm.lua"

  if [ -f "$custom_config" ]; then
    if [ -f "$target_config" ]; then
      echo "WezTerm config already exists at $target_config"
      echo "Skipping config copy to avoid overwriting existing configuration"
      return 0
    fi

    cp "$custom_config" "$target_config"
    echo "WezTerm configuration copied successfully to $target_config"
  else
    echo "Warning: Custom WezTerm config not found at $custom_config"
    echo "WezTerm will use default configuration"
  fi
}

install_wezterm() {
  echo "Installing WezTerm..."

  enable_wezterm_copr
  install_wezterm_package
  setup_wezterm_config

  echo "WezTerm installation complete!"
}

install_wezterm

