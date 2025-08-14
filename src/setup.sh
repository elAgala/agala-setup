#!/bin/bash

set -euo pipefail

DEVELOPMENT=false
if [[ "${1:-}" == "--development" ]]; then
  DEVELOPMENT=true
  echo "Running in development mode"
fi

# Export for modules
export DEVELOPMENT

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

echo "Installing Flutter..."
source "$SCRIPT_DIR/modules/flutter.sh"

echo "Installing Docker..."
source "$SCRIPT_DIR/modules/docker.sh"

echo "Installing lazygit..."
source "$SCRIPT_DIR/modules/lazygit.sh"

echo "Installing utils..."
source "$SCRIPT_DIR/modules/utils.sh"

# Only change shell if not in development mode
if [[ "$DEVELOPMENT" == "false" ]]; then
  echo "Switching to zsh shell..."
  chsh -s $(which zsh)
  
  echo "Installing Node.js 22.x in new zsh shell..."
  zsh -c "source ~/.zshrc && nvm install 22 && nvm use 22"
else
  # In development, use current shell
  if [ -f "$HOME/.nvm/nvm.sh" ]; then
    echo "Installing Node.js 22.x..."
    source "$HOME/.nvm/nvm.sh"
    nvm install 22
    nvm use 22
  fi
fi

echo "Setup complete!"
