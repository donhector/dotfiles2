#!/usr/bin/env sh

set -eux

# Symlink certain files/directories in the user's home.
link () {
  for file in $( ls -A | grep -vE '\.git$|\.gitignore|\.gitmodules|.*.md' ) ; do
    # We force the creation in case the files already existed
    ln -sfnv "${PWD}/${file}" "${HOME}"
  done
}


echo "Checking OS environment..."

# Windows Subsystem for Linux specific stuff
if [ -n "${WSL_DISTRO_NAME}" ]; then

    echo "Running under Windows Subsystem for Linux..."
    # Function to resolve Windows variables. Removes the CR windows binaries spit out
    get_win_var () { cmd.exe /c "echo ${1}" 2> /dev/null | sed -e 's/\r//g'; }
    
    # Symlink vscode settings
    VSCODE_USER_FOLDER=$(wslpath $(get_win_var %APPDATA%/Code/User/))

    if [ -d ${VSCODE_USER_FOLDER} ]; then 
        echo "Symlinking VSCode user files..."
        ln -sv ${PWD}/vscode/settings.json ${VSCODE_USER_FOLDER}/settings.json
        ln -sv ${PWD}/vscode/keybindings.json ${VSCODE_USER_FOLDER}/keybindings.json
    else
        echo "No VSCode installation found on Windows host."
    fi
fi


echo "Installing dotfiles..."
echo TODO
#link



# # shell settings
# ln -sv ${PWD}/zsh/.zshrc ~/.zshrc

# # shell settings
# ln -sv ${PWD}/bash/.bashrc ~/.bashrc

# # git configurations
# ln -sv ${PWD}/git/.gitconfig ~/.gitconfig


cat ${PWD}/dotfiles/vscode/extensions.txt | while read extension
do
    code --install-extension $extension --force
done