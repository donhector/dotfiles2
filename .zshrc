##########################################################
# Load my own stuff: shell agnostic + zsh customizations
##########################################################

# Load all common files from ~/.shellrc.d directory
if [ -d "$HOME/.shellrc.d" ]; then
  for file in $HOME/.shellrc.d/*.sh; do
    # echo "Sourcing $file"
    source $file
  done
fi

# Load all zsh preferences from the ~/.zshrc.d directory
if [ -d "$HOME/.zshrc.d" ]; then
  for file in $HOME/.zshrc.d/*.zsh; do
    # echo "Sourcing $file"
    source $file
  done
fi
