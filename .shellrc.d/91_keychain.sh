# Load SSH keys into SSH agent (needs 'apt install keychain')

function install_keychain {
    sudo apt -yqq install keychain
}

function uninstall_keychain {
	sudo apt remove keychain
}

if ! command -v keychain &> /dev/null
then
    install_keychain
else
    export HOST=$(hostname)
    /usr/bin/keychain --nogui $HOME/.ssh/id_{rsa,ed25519}
    . $HOME/.keychain/$HOST-sh
fi
