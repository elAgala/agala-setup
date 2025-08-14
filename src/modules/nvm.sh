#!/bin/bash

set -euo pipefail

install_nvm() {
  echo "Installing nvm (Node Version Manager)..."

  if [ -d "$HOME/.nvm" ]; then
    echo "nvm is already installed"
    return 0
  fi

  echo "Downloading and installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  echo "nvm installation complete!"
}

install_nvm
