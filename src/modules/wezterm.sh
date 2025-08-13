#!/bin/bash

set -euo pipefail

enable_wezterm_copr() {
    echo "Enabling WezTerm Copr repository..."
    
    # Check if the Copr repo is already enabled
    if dnf copr list enabled | grep -q "wezfurlong/wezterm-nightly"; then
        echo "WezTerm Copr repository is already enabled"
        return 0
    fi
    
    # Enable the WezTerm nightly Copr repository
    sudo dnf copr enable wezfurlong/wezterm-nightly -y
    
    echo "WezTerm Copr repository enabled successfully"
}

install_wezterm_package() {
    echo "Installing WezTerm via dnf..."
    
    # Check if WezTerm is already installed
    if command -v wezterm &> /dev/null; then
        echo "WezTerm is already installed"
        echo "Current version: $(wezterm --version)"
        return 0
    fi
    
    # Install WezTerm from the Copr repository
    sudo dnf install -y wezterm
    
    echo "WezTerm installed successfully"
}

setup_wezterm_config() {
    echo "Setting up WezTerm configuration..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local custom_config="$script_dir/../assets/.wezterm.lua"
    local target_config="$HOME/.wezterm.lua"
    
    # Check if custom config exists
    if [ -f "$custom_config" ]; then
        # Check if target config already exists
        if [ -f "$target_config" ]; then
            echo "WezTerm config already exists at $target_config"
            echo "Skipping config copy to avoid overwriting existing configuration"
            return 0
        fi
        
        # Copy the custom configuration
        cp "$custom_config" "$target_config"
        echo "WezTerm configuration copied successfully to $target_config"
    else
        echo "Warning: Custom WezTerm config not found at $custom_config"
        echo "WezTerm will use default configuration"
    fi
}

install_wezterm() {
    echo "Installing WezTerm..."
    
    # Enable Copr repository
    enable_wezterm_copr
    
    # Install WezTerm package
    install_wezterm_package
    
    # Setup configuration
    setup_wezterm_config
    
    echo "WezTerm installation complete!"
}

install_wezterm