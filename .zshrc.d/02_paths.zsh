# Add custom locations to PATH for zsh

# Add custom location (~/.zfunc) to FPATH 
echo "${FPATH}" | grep '.zfunc' || mkdir -p ~/.zfunc/ 2>&1 >/dev/null && fpath=($fpath ~/.zfunc)
