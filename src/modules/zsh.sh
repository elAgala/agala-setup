#!/bin/bash

set -euo pipefail

install_zsh_plugins() {
  echo "Installing Oh My Zsh plugins..."

  local syntax_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  if [ ! -d "$syntax_dir" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_dir"
  else
    echo "zsh-syntax-highlighting already installed"
  fi

  local suggestions_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  if [ ! -d "$suggestions_dir" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$suggestions_dir"
  else
    echo "zsh-autosuggestions already installed"
  fi

  local substring_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
  if [ ! -d "$substring_dir" ]; then
    echo "Installing zsh-history-substring-search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search "$substring_dir"
  else
    echo "zsh-history-substring-search already installed"
  fi

  echo "Oh My Zsh plugins installation complete!"
}

copy_custom_zshrc() {
  echo "Copying custom .zshrc configuration..."

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local custom_zshrc="$script_dir/../assets/.zshrc"
  local target_zshrc="$HOME/.zshrc"

  if [ -f "$custom_zshrc" ]; then
    cp "$custom_zshrc" "$target_zshrc"
    echo "Custom .zshrc copied successfully"
    echo "Configuration file: ~/.zshrc"
  else
    echo "Warning: Custom .zshrc not found at $custom_zshrc"
    echo "Using default Oh My Zsh configuration"
  fi
}

install_ohmyzsh() {
  echo "Installing Oh My Zsh..."

  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed"
    return 0
  fi

  if ! command -v curl &>/dev/null; then
    echo "Installing curl for Oh My Zsh installation..."
    sudo dnf install -y curl
  fi

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  echo "Oh My Zsh installation complete!"

  copy_custom_zshrc

  install_zsh_plugins
}

install_zsh() {
  echo "Installing zsh..."

  if command -v zsh &>/dev/null; then
    echo "zsh is already installed"
    return 0
  fi

  sudo dnf install -y zsh

  echo "zsh installation complete!"
}

install_zsh
install_ohmyzsh
