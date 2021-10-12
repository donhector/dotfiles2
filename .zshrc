### Load all common files from ~/.shellrc.d directory
if [ -d $HOME/.shellrc.d ]; then
  for file in $HOME/.shellrc.d/*.sh; do
    source $file
  done
fi

### Load all zsh preferences from the ~/.zshrc.d directory
if [ -d $HOME/.zshrc.d ]; then
  for file in $HOME/.zshrc.d/*.zsh; do
    source $file
  done
fi
