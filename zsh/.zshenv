export PATH="$HOME/.poetry/bin:$PATH"

HOSTNAME=$(hostname)
if [ ${HOSTNAME:-} = "portfolio" ]; then
  if [ -z "$SSH_AUTH_SOCK" ]; then
      eval `ssh-agent -s`
  fi
  
  eval `keychain --eval id_rsa`
fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
export PATH=$HOME/go/bin:$PATH

