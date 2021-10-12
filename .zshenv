# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH=$PATH

# Check if we are running under Windows Subsystem for Linux
if [ -n "$WSL_DISTRO_NAME" ]; then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0 
    export LIBGL_ALWAYS_INDIRECT=1
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
# This will take care of loading my preferences -aliases, settings, etc..- to those type of shells
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
