#!/bin/bash

set -euo pipefail

uname=$(uname)

case $uname in
"Darwin")
    brew update
    brew tap \
        koekeishiya/formulae

    brew install \
        fasd \
        git \
        git-town \
        htop \
        jq \
        neovim \
        node \
        stow \
        yabai

    brew install skhd --with-logging

    brew install \
        alfred \
        karabiner-elements \
        resilio-sync \
        spotify \
        visual-studio-code \
        whatsapp \
        menumeters

    if [ ! -d "$HOME/.neovim3" ]; then
        python3 -m venv "$HOME/.neovim3"
        "$HOME/.neovim3/bin/pip" install neovim
    fi
    npm install -g neovim

    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    ;;
"Linux")
    sudo apt-get update
    sudo apt-get install -y \
        curl \
        fasd \
        git \
        stow

    sudo chsh -s /usr/bin/zsh $USER

    if [ ! -d "$HOME/.asdf" ]; then
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
    fi

    . $HOME/.asdf/asdf.sh
    asdf plugin add neovim || true
    asdf install neovim stable
    asdf global neovim stable

    if [ -n "$CODER_USERNAME" ]; then
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
    fi

    ;;
esac

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

stow git
stow nvim
stow zsh

case $uname in
"Darwin")
    stow karabiner
    stow kitty
    stow yabai
    ;;
"Linux") ;;

esac
