if [ -f ~/antigen.zsh ]; then
    # Load antigen
    source ~/antigen.zsh
    if [ -f ~/.antigenrc ]; then
        # Configure antigen
        source ~/.antigenrc
    fi
fi

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
