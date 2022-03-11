### LOAD ZSH completions ###

## Enable zsh completions
autoload -Uz compinit && compinit

## Enable compatibilty with zsh for bash completions
autoload -U +X bashcompinit && bashcompinit

#####################################################

## ASDF
# append completions dir to fpath if ASDF is installed
[ -n ${ASDF_DIR} ] && fpath=($fpath ${ASDF_DIR}/completions)

## Terraform
command -v terraform 2>&1 >/dev/null && \
  complete -o nospace -C $(which terraform) terraform

## Hugo
command -v hugo 2>&1 >/dev/null && \
  hugo completion zsh > ~/.zfunc/_hugo

## Molecule
command -v molecule 2>&1 >/dev/null && \
  _MOLECULE_COMPLETE=zsh_source molecule > ~/.zfunc/_molecule_completion

## gh
command -v gh 2>&1 >/dev/null && \
  gh completion -s zsh > ~/.zfunc/_gh
