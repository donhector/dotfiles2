function install_ohmybash {
    git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
}

function update_ohmybash {
	upgrade_oh_my_bash
}

function uninstall_ohmybash {
    uninstall_oh_my_bash 
}

# Install oh-my-bash if not present
[ ! -d ~/.oh-my-bash ] && install_ohmybash

# Load my oh-my-bash settings
[ -f ~/.ohmybash ] && . ~/.ohmybash
