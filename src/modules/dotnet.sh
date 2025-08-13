#!/bin/bash

set -euo pipefail

install_dotnet() {
    echo "Installing .NET..."
    
    # Check if dotnet is already installed
    if command -v dotnet &> /dev/null; then
        echo ".NET is already installed"
        echo "Current version: $(dotnet --version)"
        return 0
    fi
    
    # Install .NET using Microsoft's official install script
    echo "Downloading and installing .NET using Microsoft's install script..."
    curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
    
    # Add dotnet to PATH for current session
    export PATH="$PATH:$HOME/.dotnet"
    
    # Verify installation
    if command -v dotnet &> /dev/null; then
        echo ".NET installation complete!"
        echo "Installed version: $(dotnet --version)"
        echo "Note: .NET has been installed to ~/.dotnet"
        echo "You may need to add ~/.dotnet to your PATH in your shell configuration"
    else
        echo "Warning: .NET installation may have failed - dotnet command not found"
    fi
}

install_dotnet