# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by **chezmoi** (migrated November 2024). It configures a macOS development environment with window management, shell, and development tools.

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

# Manual package updates:
brew update && brew upgrade
uv tool upgrade --all
```

### Window Manager Controls
```bash
# AeroSpace (tiling window manager)
# Config: dot_aerospace.toml
# Reload: hyper+shift+r (hyper = ralt+rctrl+rshift)

# skhd (hotkey daemon)
# Config: dot_skhdrc
# Reload: brew services restart skhd
```

## Architecture

### Chezmoi Template System
- **Directory structure**: Files prefixed with `dot_` become `.` files, `private_` for sensitive data
- **Templates**: `.tmpl` files use Go templating with OS-specific logic
- **Package definitions**: `.chezmoidata/packages.yaml` defines all installable packages
- **Auto-installation**: `run_once_before_install-packages-darwin.sh.tmpl` runs on first apply

### Key Configuration Files
- `dot_aerospace.toml` - Window manager with workspace rules and app assignments
- `dot_skhdrc` - Keyboard shortcuts using hyper key (ralt+rctrl+rshift)
- `private_dot_config/private_fish/config.fish.tmpl` - Fish shell with vi bindings
- `git/.gitconfig` - Git with SSH signing via 1Password

### Window Management Architecture
- **Hyper key**: Karabiner maps caps_lock to hyper (ralt+rctrl+rshift)
- **Workspaces**: 1-9, A, Q, W, E with specific monitor assignments
- **Navigation**: hjkl for focus, Shift+hjkl for moving windows
- **App rules**: Automatic workspace assignments (e.g., Discord→E, Notes→1)

## Development Patterns

### Adding New Configurations
1. Create file with appropriate prefix (`dot_`, `private_`)
2. Add `.tmpl` suffix if OS-specific logic needed
3. Use template variables: `{{ .chezmoi.os }}`, `{{ .packages.* }}`
4. Run `chezmoi apply` to deploy

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
   - `python.uv.tools` for Python tools
2. Template automatically installs via `brew bundle` and `uv tool install`

## Important Notes

- **Migration Status**: Legacy directories (hammerspoon/, kitty/, nvim/, etc.) are ignored via `.chezmoiignore`
- **File Permissions**: `private_` prefix sets files to chmod 600 (owner read/write only)
- **1Password Integration**: Git signing requires 1Password CLI
- **OS Support**: Primarily macOS-focused with conditional Linux support via templates
