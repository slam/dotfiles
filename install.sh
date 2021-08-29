#!/bin/bash

sudo apt-get update
sudo apt-get install -y \
    curl \
    fasd \
    git

sudo chsh -s /usr/bin/zsh $USER

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
fi

. $HOME/.asdf/asdf.sh
asdf plugin add neovim
asdf install neovim stable
asdf global neovim stable

echo "Symlinking all files and directories starting with '.' into $HOME"

for dotfile in "$PWD"/.*; do
    # Skip `..` and '.'
    [[ $dotfile =~ \.{1,2}$ ]] && continue
    # Skip Git related
    [[ $dotfile =~ \.git$ ]] && continue
    [[ $dotfile =~ \.gitignore$ ]] && continue
    [[ $dotfile =~ \.gitattributes$ ]] && continue

    echo "Symlinking $dotfile"
    ln -sf "$dotfile" "$HOME"
done
