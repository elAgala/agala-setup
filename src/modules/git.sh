#!/bin/bash

set -euo pipefail

install_git() {
  echo "Installing git..."

  if command -v git &>/dev/null; then
    echo "git is already installed"
    return 0
  fi

  sudo dnf install -y git

  echo "git installation complete!"
}

install_git

