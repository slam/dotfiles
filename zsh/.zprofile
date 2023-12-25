# On MacOS, Apple overrides the PATH set in .zshenv by setting its own PATH in
# /etc/zprofile. We have to set our PATH in .zprofile.
#
# https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden
export PATH="$HOME/.poetry/bin:$PATH"

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

export PATH=$HOME/go/bin:$PATH

if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

if [ -f "$HOME/.zprofile.local" ]; then
  . "$HOME/.zprofile.local"
fi
