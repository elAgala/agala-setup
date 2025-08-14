install_docker() {
  echo "Installing Docker..."

  if command -v docker &>/dev/null; then
    echo "Docker is already installed"
    echo "Current version: $(docker --version)"
    return 0
  fi

  echo "Removing old Docker packages..."
  sudo dnf remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine 2>/dev/null || true

  echo "Installing DNF plugins..."
  sudo dnf -y install dnf-plugins-core
  sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

  echo "Installing Docker packages..."
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Skip service management in development mode (Docker containers)
  if [[ "$DEVELOPMENT" == "false" ]]; then
    echo "Starting and enabling Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker

    echo "Adding user to docker group..."
    sudo usermod -aG docker $USER
  else
    echo "Skipping Docker service start (development mode)"
  fi

  echo "Docker installation complete!"
}

install_docker

