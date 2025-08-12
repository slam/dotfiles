# dotfiles

My dotfiles managed with [chezmoi](https://www.chezmoi.io/) (migrated November 2024).

Supports:
- **macOS** - Window management with AeroSpace, development tools
- **Omarchy** - Hyprland, Waybar, Hyper key via interception-tools

## Setting up Omarchy

### Quick Setup

```bash
# Install chezmoi
sudo pacman -S chezmoi

# Initialize and apply dotfiles
chezmoi init --apply slam/dotfiles
```

This will:
- Install packages via pacman and AUR (yay)
- Configure Hyper key (Caps Lock = Escape/MOD5)
- Set up Hyprland with custom keybindings
- Configure terminal (Ghostty), editor (VSCodium)

## Setting up a new Mac

### Prerequisites

1. **Install Homebrew** (if not already installed):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **Install 1Password** (for SSH key management):
```bash
brew install --cask 1password 1password-cli
```
Configure 1Password and sign in to access your SSH keys.

### Quick Setup

1. **Install chezmoi and apply dotfiles**:
```bash
# Install chezmoi with Homebrew
brew install chezmoi

# Initialize and apply dotfiles
chezmoi init --apply slam/dotfiles
```

2. **Set up SSH keys** (if using 1Password):
   - Open 1Password and ensure SSH agent integration is enabled
   - Your git commits will be signed automatically via 1Password
