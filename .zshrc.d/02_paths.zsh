# Add custom locations to PATH or FPATH for zsh

# Add custom function path location (~/.zfunc) to FPATH
echo "${FPATH}" | grep '.zfunc' || mkdir -p ~/.zfunc/ 2>&1 >/dev/null && fpath=($fpath ~/.zfunc)
