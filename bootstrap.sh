#!/usr/bin/env bash

# Install basic packages
sudo apt update && \
sudo apt install -y --no-install-recommends \
    zip \
    unzip \
    net-tools \
    tree \
    htop \
    iotop \
    dnsutils \
    whois \
    wget \
    curl \
    git


# Install zsh and set it as default shell
sudo apt install -y zsh
chsh -s $(which zsh)

# Download Antigen, the plugin manager for zsh.
curl -L git.io/antigen > ~/antigen.zsh



################################
# asdf setup
################################

# # Deps for python plugin (ie: pyenv deps)
# sudo apt install -y --no-install-recommends \
#     make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
#     get curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# # Deps for nodejs
# sudo apt install -y --no-install-recommends dirmngr gpg curl
# bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

# PLUGINS=( golang nodejs python )

# if [ -f $HOME/.asdf/asdf.sh ]; then
#     for plugin in "${PLUGINS[@]}"; do
#         installed=$(asdf plugin list)
#         echo "${installed}" | grep -q ${plugin} && \
#             (
#                 echo Installing "${plugin}" asdf plugin; \
#                 asdf plugin-add ${plugin}; \
#                 asdf install ${plugin} latest; \
#                 asdf global ${plugin} latest;
#             )
#     done
# fi
