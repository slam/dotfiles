#!/bin/bash

cd $(git rev-parse --show-toplevel)
mkdir -p patches

(cd $HOME/.config/nvim && git diff) > patches/nvchad.patch
