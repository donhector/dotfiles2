##########################################################
# Load my own stuff: shell agnostic + bash customizations
##########################################################

# Load all common files from ~/.shellrc.d directory
if [ -d $HOME/.shellrc.d ]; then
  for file in $HOME/.shellrc.d/*.sh; do
    source $file
  done
fi

# Load all zsh preferences from the ~/.zshrc.d directory
if [ -d $HOME/.zshrc.d ]; then
  for file in $HOME/.zshrc.d/*.zsh; do
    source $file
  done
fi

# Load SSH keys (needs 'apt install keychain')
if ! command -v keychain &> /dev/null
then
    echo "keychain could not be found. Did you do 'apt install keychain'?"
    exit
else
    /usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
    source $HOME/.keychain/$HOST-sh
fi