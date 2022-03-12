# Neofetch setup

install_neofetch() {
    sudo apt -yqq install neofetch
}

uninstall_neofetch() {
	sudo apt remove neofetch
}

if ! command -v neofetch &> /dev/null
then
    install_neofetch
fi

# Show neofetch info
#neofetch 2>/dev/null