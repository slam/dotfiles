# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by **chezmoi** (migrated November 2024). It supports both macOS and Omarchy (Arch Linux) with platform-specific configurations for window management, shell, and development tools.

## Critical Rules for Claude

1. **NEVER commit unless explicitly asked** - Do not proactively commit changes. Wait for explicit user request.
2. **ALWAYS check platform compatibility** - When adding new configs, ensure they're added to `.chezmoiignore` for incompatible platforms
3. **Use chezmoi commands** - Always use `chezmoi add`, `chezmoi edit`, etc. instead of directly manipulating files
4. **Platform testing** - Consider both macOS and Omarchy when making changes

## Essential Commands

### Apply Configuration Changes
```bash
chezmoi apply  # Apply all template changes to the system
chezmoi diff   # Preview changes before applying
```

### Package Management
```bash
# Packages are defined in .chezmoidata/packages.yaml
# To add packages: edit the YAML file, then run:
chezmoi apply  # Automatically runs package installation

# macOS:
brew update && brew upgrade

# Omarchy:
yay -Syu

# Python tools (both platforms):
uv tool upgrade --all
```

### Window Manager Controls

#### macOS (AeroSpace + skhd)
```bash
# Config: dot_aerospace.toml, dot_skhdrc
# Reload AeroSpace: hyper+shift+r
# Reload skhd: brew services restart skhd
```

#### Omarchy (Hyprland)
```bash
# Config: .config/hypr/*.conf
# Reload: hyprctl reload
# Hyper key: Caps Lock (tap=Esc, hold=MOD5) via interception-tools
```

## Architecture

### Chezmoi Template System
- **Directory structure**: Files prefixed with `dot_` become `.` files, `private_` for sensitive data
- **Templates**: `.tmpl` files use Go templating with OS-specific logic
- **Package definitions**: `.chezmoidata/packages.yaml` defines all installable packages
- **Auto-installation**: `run_once_before_install-packages-darwin.sh.tmpl` runs on first apply

### Key Configuration Files

#### macOS
- `dot_aerospace.toml` - Tiling window manager with workspace rules
- `dot_skhdrc` - Keyboard shortcuts using hyper key
- `.config/karabiner/` - Caps Lock to Hyper key mapping

#### Omarchy
- `.config/hypr/` - Hyprland window manager configuration
- `.config/waybar/` - Status bar configuration
- `.config/ghostty/` - Terminal emulator configuration
- `/etc/interception/` - Hyper key setup (managed by install script)

#### Both Platforms
- `dot_gitconfig.tmpl` - Git with OS-specific editor and SSH signing
- `private_dot_config/private_fish/config.fish.tmpl` - Fish shell with vi bindings

### Window Management Architecture

#### Hyper Key Implementation
- **macOS**: Karabiner-Elements maps Caps Lock to Ctrl+Alt+Shift+Cmd
- **Omarchy**: interception-tools maps Caps Lock to Escape (tap) / MOD5 (hold)

#### Navigation (both platforms)
- **Focus**: Hyper + hjkl
- **Move windows**: Hyper + Shift + hjkl
- **Workspaces**: Hyper + 1-9, 0

## Development Patterns

### Adding New Configurations
1. Add existing files to chezmoi:
   ```bash
   chezmoi add ~/.config/someapp/config
   chezmoi add --encrypt ~/.ssh/config  # For sensitive files
   ```
2. Edit managed files:
   ```bash
   chezmoi edit ~/.config/someapp/config
   ```
3. For OS-specific configs, convert to template:
   ```bash
   chezmoi add --template ~/.gitconfig
   ```
4. Apply changes:
   ```bash
   chezmoi diff    # Preview changes
   chezmoi apply   # Apply changes
   ```

### Template Conditionals
```go
{{ if eq .chezmoi.os "darwin" -}}
  # macOS-specific configuration
{{ end -}}
```

### Package Management Pattern
1. Define in `.chezmoidata/packages.yaml`:
   - `darwin.brews` for Homebrew formulas
   - `darwin.casks` for GUI applications
   - `arch.pacman` for official Arch packages
   - `arch.aur` for AUR packages
   - `python.uv.tools` for Python tools (cross-platform)
2. Install scripts run automatically:
   - macOS: `run_once_before_install-packages-darwin.sh.tmpl`
   - Omarchy: `run_once_before_install-packages-arch.sh.tmpl`

## Important Notes

- **File Permissions**: `private_` prefix sets files to chmod 600 (owner read/write only)
- **1Password Integration**: Git signing requires 1Password CLI (both platforms)
- **OS Detection**: Templates use `{{ .chezmoi.os }}` and `{{ .chezmoi.osRelease.id }}`
- **Platform-specific files**: Managed via `.chezmoiignore` with template conditionals
