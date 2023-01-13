### LOAD ZSH completions ###

## Enable zsh completions
autoload -Uz compinit && compinit

## Enable compatibilty with zsh for bash completions
autoload -Uz +X bashcompinit && bashcompinit

#####################################################

## ASDF
# append completions dir to fpath if ASDF is installed
[ -n ${ASDF_DIR} ] && fpath=($fpath ${ASDF_DIR}/completions)

## Terraform
command -v terraform >/dev/null 2>&1 \
  && complete -o nospace -C $(which terraform) terraform

## Hugo
command -v hugo >/dev/null 2>&1 \
  && hugo completion zsh > ~/.zfunc/_hugo

## Molecule
command -v molecule >/dev/null 2>&1 \
  && _MOLECULE_COMPLETE=zsh_source molecule > ~/.zfunc/_molecule_completion

## gh
command -v gh >/dev/null 2>&1 \
  && gh completion -s zsh > ~/.zfunc/_gh

## Ripgrep
command -v rg >/dev/null 2>&1 \
  && cp "$(asdf where ripgrep)/complete/_rg" ~/.zfunc/

## Fd
command -v fd >/dev/null 2>&1 \
  && cp "$(asdf where fd)/autocomplete/_fd" ~/.zfunc/

## Kubectl
command -v kubectl >/dev/null 2>&1 \
  && kubectl completion zsh > ~/.zfunc/_kubectl \
  && compdef __start_kubectl k
  # enables autocomplete also when aliased to k

## Aws
command -v aws >/dev/null 2>&1 \
  && complete -C $(which aws_completer) aws

## helm
command -v helm >/dev/null 2>&1 \
  && helm completion zsh > ~/.zfunc/_helm

## grype
command -v grype >/dev/null 2>&1 \
  && grype completion zsh > ~/.zfunc/_grype

## poetry
command -v poetry >/dev/null 2>&1 \
  && poetry completions zsh > ~/.zfunc/_poetry

## pip
command -v pip >/dev/null 2>&1 \
  && eval "$(pip completion --zsh)" \
  && compctl -K _pip_completion pip3

## pipenv
command -v pipenv >/dev/null 2>&1 \
  && eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

## krew
command -v kubectl-krew >/dev/null 2>&1 \
  && kubectl-krew completion zsh > ~/.zfunc/_krew

## starship
command -v starship >/dev/null 2>&1 \
  && starship completions zsh > ~/.zfunc/_starship
