#!/bin/bash

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Updating Fedora packages..."
sudo dnf update -y

echo "Package update complete!"

echo "Installing git..."
source "$SCRIPT_DIR/modules/git.sh"

echo "Installing zsh & oh-my-zsh..."
source "$SCRIPT_DIR/modules/zsh.sh"

echo "Installing Neovim..."
source "$SCRIPT_DIR/modules/nvim.sh"

echo "Installing WezTerm..."
source "$SCRIPT_DIR/modules/wezterm.sh"

echo "Installing nvm..."
source "$SCRIPT_DIR/modules/nvm.sh"

echo "Installing .NET..."
source "$SCRIPT_DIR/modules/dotnet.sh"

echo "Setup complete!"

echo "Switching to zsh shell..."
exec chsh -s $(which zsh)
