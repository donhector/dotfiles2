if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

function install_fzf {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function update_fzf {
	cd ~/.fzf && git pull && ./install
}

function uninstall_fzf {
	cd ~/.fzf && ./uninstall
}
