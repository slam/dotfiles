#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl git

sudo chsh -s /usr/bin/zsh $USER

if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
fi
