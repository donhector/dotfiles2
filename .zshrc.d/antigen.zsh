# Setup Antigen, the plugin manager for Zsh

function install_antigen {
    curl -L git.io/antigen > ~/antigen.zsh
}

function update_antigen {
	install_antigen
}

function uninstall_antigen {
	rm -rf ~/antigen.zsh
    rm -rf ~/.antigen/
}

if [ -f ~/antigen.zsh ]; then
    # Load antigen
    source ~/antigen.zsh
    if [ -f ~/.antigenrc ]; then
        # Configure antigen as per my linking
        source ~/.antigenrc
    fi
else
    install_antigen
fi