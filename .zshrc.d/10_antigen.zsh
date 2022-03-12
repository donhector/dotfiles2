# Setup Antigen, the plugin manager for Zsh

install_antigen() {
    echo "Installing Antigen, the plugin manager for Zsh"
    curl -L git.io/antigen > ~/antigen.zsh
}

update_antigen() {
	install_antigen
}

uninstall_antigen() {
	rm -rf ~/antigen.zsh
    rm -rf ~/.antigen/
}


# Install antigen if not present
[ ! -f ~/antigen.zsh ] && install_antigen

# If installed, load it and use my conifg
if [ -f ~/antigen.zsh ]; then
    # Load antigen
    source ~/antigen.zsh
    if [ -f ~/.antigenrc ]; then
        # Load my config
        source ~/.antigenrc
    fi
fi
