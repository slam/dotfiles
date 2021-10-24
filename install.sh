#!/bin/bash

set -euo pipefail

uname=$(uname)

set -x
case $uname in
"Darwin")
    brew update
    brew tap homebrew/cask-fonts
    brew tap koekeishiya/formulae

    brew install \
        fasd \
        git \
        git-town \
        go \
        htop \
        jq \
        neovim \
        node@14 \
        stow \
        yabai

    brew link --overwrite node@14
    brew install skhd --with-logging

    brew install \
        alfred \
        karabiner-elements \
        resilio-sync \
        spotify \
        visual-studio-code \
        whatsapp \
        menumeters

    brew install \
        font-meslo-lg-nerd-font

    if [ ! -d "$HOME/.neovim3" ]; then
        python3 -m venv "$HOME/.neovim3"
        "$HOME/.neovim3/bin/pip" install neovim
    fi
    if [ ! -d "/usr/local/lib/node_modules/neovim" ]; then
        npm install -g neovim
    fi

    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    ;;
"Linux")
    sudo apt-get update
    sudo apt-get install -y \
        build-essential \
        curl \
        fasd \
        git \
        stow \
        zsh

    sudo chsh -s /usr/bin/zsh $USER

    # golang
    if [ ! -d "/usr/local/go" ]; then
        curl -O https://dl.google.com/go/go1.17.2.linux-amd64.tar.gz
        tar xvf go1.17.2.linux-amd64.tar.gz -C /tmp
        sudo chown -R root:root /tmp/go
        sudo mv /tmp/go /usr/local/
        sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go
        sudo ln -sf /usr/local/go/bin/gofmt /usr/local/bin/gofmt
        hash -r
    fi

    if [ ! -d "$HOME/.asdf" ]; then
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
    fi

    . $HOME/.asdf/asdf.sh
    asdf plugin add neovim || true
    asdf install neovim stable
    asdf global neovim stable

    if [ -n "${CODER_USERNAME:-}" ]; then
        if [ ! -d "$HOME/.neovim2" ]; then
            pip install --user virtualenv
            "$HOME/.local/bin/virtualenv" "$HOME/.neovim2"
            "$HOME/.neovim2/bin/pip" install neovim
        fi

        if [ ! -d "$HOME/.neovim3" ]; then
            python3.7 -m venv "$HOME/.neovim3"
            "$HOME/.neovim3/bin/pip" install neovim
        fi

        mkdir -p "$HOME/.npm-packages"
        npm config set prefix "$HOME/.npm-packages"

        if [ ! -d "$HOME/.npm-packages/lib/node_modules/neovim" ]; then
            npm install -g neovim
        fi

        if [ ! -d "$HOME/.npm-packages/lib/node_modules/pyright" ]; then
            npm install -g pyright
        fi
    fi

    ;;
esac

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [ ! -d "$HOME/.config/nvim/.git" ]; then
    if [ -e "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.orig"
    fi
    git clone https://github.com/NvChad/NvChad ~/.config/nvim
fi

if ! command -v rustup >/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    . "$HOME/.cargo/env"
fi
rustup install stable

if [ ! -x "$HOME/.cargo/bin/rg" ]; then
    cargo install ripgrep
fi

# Formatters
if [ ! -x "$HOME/.cargo/bin/stylua" ]; then
    cargo install stylua
fi
if [ ! -x "$HOME/go/bin/shfmt" ]; then
    go install mvdan.cc/sh/v3/cmd/shfmt@latest
fi

stow git
stow zsh

stow nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

case $uname in
"Darwin")
    stow karabiner
    stow kitty
    stow yabai

    cargo install --git https://github.com/slam/yabaictl --branch main
    ln -sf "$HOME/.cargo/bin/yabaictl" /usr/local/bin/yabaictl
    ln -sf "$HOME/bin/yabaifocus" /usr/local/bin/yabaifocus
    ln -sf "$HOME/bin/yabailayout" /usr/local/bin/yabailayout
    ;;
"Linux") ;;

esac
