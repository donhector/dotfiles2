# Add custom locations to PATH

if [ -d "/usr/local/go" ]; then
    PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/go" ]; then
    PATH="$HOME/go/bin:$PATH"
fi

# Make the changes available in the environment
export PATH=$PATH
