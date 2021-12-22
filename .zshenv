# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH=$PATH

# Ensure that a non-login, non-interactive shell has a defined environment.
# This will take care of loading my preferences -aliases, settings, etc..- to those type of shells
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi
