#!/usr/bin/env sh

# Install fd, a 'find' replacement that works well with fzf

FD_VERSION=8.2.1
FD_FILENAME=fd_${FD_VERSION}_amd64.deb

function install_fd {
    wget -q -N https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/${FD_FILENAME} -P /tmp
    sudo apt -yqq install /tmp/${FD_FILENAME}
}

function uninstall_fd {
	sudo apt remove fd
}

# Install fd if not present
if ! command -v fd &> /dev/null
then
    install_fd
fi