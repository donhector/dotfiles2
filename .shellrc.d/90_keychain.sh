# Load SSH keys into SSH agent (needs 'apt install keychain')

install_keychain() {
    sudo apt -yqq install keychain
}

uninstall_keychain() {
	sudo apt remove keychain
}

if ! command -v keychain &> /dev/null
then
    install_keychain
else
    export HOST=$(hostname)
    /usr/bin/keychain --nogui $HOME/.ssh/id_{rsa,ed25519}
    source $HOME/.keychain/$HOST-sh
fi
