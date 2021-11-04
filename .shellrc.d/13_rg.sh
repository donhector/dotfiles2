#!/usr/bin/env sh

# Install rg (ripgrep), a better 'grep' replacement

RG_VERSION=13.0.0
RG_FILENAME=ripgrep_${RG_VERSION}_amd64.deb

function install_rg {
    wget -q -N https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${RG_FILENAME} -P /tmp
    sudo apt -yqq install /tmp/${RG_FILENAME}
}

function uninstall_rg {
	sudo apt remove ripgrep
}

# Install rg if not present
if ! command -v rg &> /dev/null
then
    install_rg
fi
