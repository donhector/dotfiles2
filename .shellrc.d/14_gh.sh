#!/usr/bin/env sh

# Install gh, the cli tool for Github

install_gh() {
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
}

uninstall_gh() {
	sudo apt remove gh
}

# Install gh if not present
if ! command -v gh > /dev/null 2>&1
then
    install_gh
fi

#alias gpr='gh pr create --fill -a @me'
