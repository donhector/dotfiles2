# ASDF software manager setup

function install_asdf {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    cd ~/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"
}

function update_asdf {
    asdf update
}

function uninstall_asdf {
    rm -rf ${ASDF_DATA_DIR:-$HOME/.asdf} #~/.tool-versions
}

# Install it if not present
if [ ! -d ~/.asdf ]; then
    install_asdf
fi

# Load it
if [ -f ~/.asdf/asdf.sh ]; then
    . ~/.asdf/asdf.sh
fi

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
