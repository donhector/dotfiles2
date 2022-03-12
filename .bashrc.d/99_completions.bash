### Load bash completions

## ASDF
[ -n "${ASDF_DIR}" ] \
  && source ~/.asdf/completions/asdf.bash

## Hugo
command -v hugo >/dev/null 2>&1 \
  && source <(hugo completion bash)
  # Alternative: 'hugo completion bash > /etc/bash_completion.d/hugo'

## Molecule
command -v molecule >/dev/null 2>&1 \
  && eval "$(_MOLECULE_COMPLETE=bash_source molecule)"

## GH
command -v gh >/dev/null 2>&1 \
  && eval "$(gh completion -s bash)"

## Terraform
command -v terraform >/dev/null 2>&1 \
  && \
    complete -C "$(which terraform)" terraform

## Ripgrep
command -v rg >/dev/null 2>&1 \
  && source "$(asdf where ripgrep)/complete/rg.bash"

## Fd
command -v rg >/dev/null 2>&1 \
  && source "$(asdf where fd)/autocomplete/fd.bash"


## Kubectl
command -v kubectl >/dev/null 2>&1 \
  && source <(kubectl completion bash) \
  && complete -F __start_kubectl k

## Aws
command -v aws >/dev/null 2>&1 \
  && complete -C "$(which aws_completer)" aws

## Helm
command -v helm >/dev/null 2>&1 \
  && helm completion bash > /etc/bash_completion.d/helm

## Grype
command -v grype >/dev/null 2>&1 \
  && source <(grype completion bash)
