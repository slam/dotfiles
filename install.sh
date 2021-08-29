#!/bin/bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
    curl \
    fasd \
    git \
    stow

sudo chsh -s /usr/bin/zsh $USER

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
fi

. $HOME/.asdf/asdf.sh
asdf plugin add neovim
asdf install neovim stable
asdf global neovim stable

stow git
stow zsh
