# dotfiles

My dotfiles managed with [chezmoi](https://www.chezmoi.io/) (migrated November 2024).

Supports:
- **macOS** - Window management with AeroSpace, development tools
- **Omarchy** - Hyprland, Waybar, MOD5 modifier key via interception-tools

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
- Configure MOD5 modifier key (Caps Lock = Escape/MOD5)
- Set up Hyprland with custom keybindings

### MOD5 Modifier Key Technical Details

The MOD5 modifier (serving as a "hyper-style" key for window management) works through an event processing chain that allows multiple keyboard remapping tools to coexist:

**Event Processing Chain**:
```
Physical Keyboard → interception-tools → Virtual Keyboard → keyd → Final Virtual Keyboard → System
```

1. **interception-tools** (kernel level):
   - Intercepts the physical keyboard device exclusively
   - Processes Caps Lock: TAP → Escape, HOLD → Caps Lock
   - Creates a virtual keyboard via `uinput` that passes all events downstream

2. **keyd** (processes virtual keyboard):
   - Receives events from interception-tools' virtual keyboard
   - Handles Alt+bracket remappings for tab switching and browser navigation
   - Creates its own virtual keyboard for final output

3. **XKB Configuration** (Hyprland):
   - `kb_options = lv3:caps_switch` in `.config/hypr/input.conf`
   - Maps Caps Lock to ISO_Level3_Shift (see `/usr/share/X11/xkb/symbols/level3`)
   - ISO_Level3_Shift conventionally maps to MOD5 in XKB

Benefits:
- No conflicts between tools (each processes a different device in the chain)
- Reliable dual-function Caps Lock via interception-tools
- Clean Alt+bracket remappings via keyd
- MOD5 modifier for window management that doesn't conflict with application shortcuts

### 1Password Setup with 2FA

For 1Password to store its own 2FA token on Omarchy, you need to set up a password keyring:

1. **Create a password keyring using Seahorse**:
   - Launch Seahorse (GNOME Passwords and Keys)
   - Click the + sign, choose "Password keyring"
   - Name it anything you like
   - Right-click the keyring and set as default

2. **Configure 1Password**:
   - 1Password will now be able to store its 2FA token in the keyring
   - This enables persistent login without re-entering 2FA on each restart

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
