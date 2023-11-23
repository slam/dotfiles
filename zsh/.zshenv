export PATH="$HOME/.poetry/bin:$PATH"

HOSTNAME=$(hostname)
if [ ${HOSTNAME:-} = "portfolio" ]; then
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s)
  fi

  eval $(keychain --eval id_rsa)
fi

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

if [ -f "$HOME/.zshenv.local" ]; then
  . "$HOME/.zshenv.local"
fi
