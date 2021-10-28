#!/usr/bin/env sh

# Install bat, a 'cat' replacement that works well with fzf

BAT_VERSION=0.18.3
BAT_FILENAME=bat_${BAT_VERSION}_amd64.deb
function install_bat {
    wget -q -N https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/${BAT_FILENAME} -P /tmp
    sudo apt -yqq install /tmp/${BAT_FILENAME}
}

function uninstall_bat {
	sudo apt remove bat
}

# Install bat if not present
if ! command -v bat &> /dev/null
then
    install_bat
fi
