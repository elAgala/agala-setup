#!/bin/bash

set -euo pipefail

install_dotnet() {
  echo "Installing .NET..."

  local download_dir="/tmp/dotnet-install"
  local install_dir="/opt/dotnet"

  if command -v dotnet &>/dev/null; then
    echo ".NET is already installed"
    echo "Current version: $(dotnet --version)"
    return 0
  fi

  mkdir -p "$download_dir"
  cd "$download_dir"

  echo "Downloading and installing .NET..."
  curl -fLO https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.304/dotnet-sdk-9.0.304-linux-x64.tar.gz

  sudo mkdir -p "$install_dir"
  sudo tar -C "$install_dir" -xzf dotnet-sdk-9.0.304-linux-x64.tar.gz

  rm -rf "$download_dir"

  if command -v dotnet &>/dev/null; then
    echo ".NET installed to /opt/dotnet"
    echo "Installed version: $(dotnet --version)"
  else
    echo "Warning: .NET installation may have failed - dotnet command not found"
  fi
}

install_dotnet
