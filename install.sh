#!/usr/bin/env sh

set -eu

# Symlink certain files/directories in the user's home.
link () {
  for file in $( \ls -A | grep -vE '\.git$|\.gitignore$|\.gitmodules$|.*.md$|.*.sh$' ) ; do
    # We force the creation in case the files already existed
    #echo "${PWD}/${file} --> ${HOME}"
    ln -sfnv "${PWD}/${file}" "${HOME}"
  done
}

while true
do
    read -r -p "Do you want to setup 'zsh' as your default shell? [y/n] " input
    case $input in
        [yY])
            # Install zsh and set it as default shell
            sudo apt install -yqq zsh
            chsh -s $(which zsh) && echo "Success! Please restart your terminal for the changes to apply."
            break
            ;;
        [nN])
            break
            ;;
        *)
            echo "Please answer yes or no..."
            ;;
    esac
done


echo "Installing (ie. symlinking) dotfiles..."
link

# echo "Checking OS environment..."

# # Windows Subsystem for Linux specific stuff
# if [ -n "${WSL_DISTRO_NAME}" ]; then

#     echo "Running under Windows Subsystem for Linux..."
#     # Function to resolve Windows variables. Removes the CR windows binaries spit out
#     get_win_var () { cmd.exe /c "echo ${1}" 2> /dev/null | sed -e 's/\r//g'; }
    
#     # Symlink vscode settings
#     VSCODE_USER_FOLDER=$(wslpath $(get_win_var %APPDATA%/Code/User))
#     if [ -d ${VSCODE_USER_FOLDER} ]; then 
#         echo "Copying VSCode user setting files..."
#         cp -fv "${PWD}/.config/Code/User/settings.json" "${VSCODE_USER_FOLDER}/settings.json"
#         cp -fv "${PWD}/.config/Code/User/keybindings.json" "${VSCODE_USER_FOLDER}/keybindings.json"

#         echo "Installing VSCode extensions..."
#         cat "${PWD}/.config/Code/User/extensions.txt" | while read extension
#         do
#           code --install-extension ${extension} --force
#         done
#     else
#         echo "No VSCode installation found on Windows host."
#     fi

#     # Symlink Windows Terminal settings
#     WINTERM_USER_FOLDER=$(wslpath $(get_win_var %LOCALAPPDATA%/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/RoamingState))
#     if [ -d ${WINTERM_USER_FOLDER} ]; then 
#         echo "Copying Windows Terminal user settings.json..."
#         cp -fv "${PWD}/.wsl2/WindowsTerminal/settings.json" "${WINTERM_USER_FOLDER}/settings.json"
#     else
#         echo "No Windows Terminal installation found on Windows host."
#     fi

# fi
