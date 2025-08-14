#!/bin/bash

set -euo pipefail

install_flutter() {
  echo "Installing Flutter..."

  local download_dir="/tmp/flutter-install"
  local install_dir="$HOME/.development"

  if command -v flutter &>/dev/null; then
    echo "Flutter is already installed"
    return 0
  fi

  echo "Installing Flutter dependencies"
  sudo dnf install -y curl git unzip xz zip mesa-libGLU

  mkdir -p "$download_dir"
  cd "$download_dir"

  echo "Downloading and installing Flutter..."
  curl -fLO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.8-stable.tar.xz

  mkdir -p "$install_dir"
  tar -C "$install_dir" -xf flutter_linux_3.32.8-stable.tar.xz

  rm -rf "$download_dir"

  echo "Flutter installed to $HOME/.development/flutter"
}

install_flutter
