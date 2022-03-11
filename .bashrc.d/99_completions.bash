### Load bash completions

## ASDF
[ -n "${ASDF_DIR}" ] && \
  source ~/.asdf/completions/asdf.bash

## Hugo
command -v hugo 2>&1 >/dev/null && \
  source <(hugo completion bash)
  # Alternative: 'hugo completion bash > /etc/bash_completion.d/hugo'

## Molecule
command -v molecule 2>&1 >/dev/null && \
  eval "$(_MOLECULE_COMPLETE=bash_source molecule)"

## GH
command -v gh 2>&1 >/dev/null && \
  eval "$(gh completion -s bash)"

## Terraform
command -v terraform 2>&1 >/dev/null && \
  complete -C $(which terraform) terraform
