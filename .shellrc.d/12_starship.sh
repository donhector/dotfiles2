# Setup starship, the command prompt customization tool

install_starship() {
    echo "Installing starship, the command prompt customization tool"
    curl -sS https://starship.rs/install.sh | sh
}

update_starship() {
	install_starship
}

uninstall_starship() {
	rm /usr/local/bin/starship
    rm ~/.config/starship.toml
}

# Install starship if not present
hash starship 2>/dev/null || install_starship

# Initialize it
eval "$(starship init "${SHELL}")"

# Enables or disbales specific modules from displaying
stoggle(){
    starship toggle "${1}"
}
