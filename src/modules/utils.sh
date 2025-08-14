install_pop_shell() {
  echo "Installing Pop Shell..."
  sudo dnf install -y gnome-shell-extension-pop-shell xprop
  echo "Pop Shell installation complete!"
}

install_pop_shell
