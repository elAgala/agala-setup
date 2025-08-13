#!/bin/bash

set -euo pipefail

install_nvm() {
    echo "Installing nvm (Node Version Manager)..."
    
    # Check if nvm is already installed
    if [ -d "$HOME/.nvm" ]; then
        echo "nvm is already installed"
        return 0
    fi
    
    # Install nvm using the official install script
    echo "Downloading and installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    
    echo "nvm installation complete!"
    echo "Note: nvm configuration is already included in your custom .zshrc"
    echo "To use nvm immediately, run: source ~/.bashrc or restart your shell"
}

install_nvm