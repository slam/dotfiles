# Don't set PATH here or it will get overridden on MacOS
#
# https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden

HOSTNAME=$(hostname)
if [ ${HOSTNAME:-} = "portfolio" ]; then
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s)
  fi

  eval $(keychain --eval id_rsa)
fi

if [ -f "$HOME/.zshenv.local" ]; then
  . "$HOME/.zshenv.local"
fi
