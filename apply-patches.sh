#!/bin/bash

set -euo pipefail
set -x

cd $(git rev-parse --show-toplevel)

(cd $HOME/.config/nvim && git diff) > /tmp/nvchad-$$.patch
(cd $HOME/.config/nvim && git reset --hard HEAD)
(cd $HOME/.config/nvim && patch -p1) < patches/nvchad.patch
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

