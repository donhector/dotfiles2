#!/usr/bin/env sh

### Set FZF_HOME variable

fzf_home(){
  fzf_location=$(which fzf)
  case "${fzf_location}" in
    *shims*) fzf_location=$(asdf which fzf) ;;
    *) ;;
  esac
  echo "$(dirname $(dirname ${fzf_location}))"
}

export FZF_HOME="$(fzf_home)"


### Customize fzf settings
EXCLUDE_ARGS='--exclude .git --exclude node_modules --exclude .npm --exclude .cache --exclude .vscode-server --exclude .venv --exclude .local'
FD_OPTS="--hidden --follow ${EXCLUDE_ARGS}"

fzf_compgen_path() {
  fd "${FD_OPTS}" . "$1"
}

fzf_compgen_dir() {
  fd "${FD_OPTS}" --type d . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

# Setting fd as the default source for fzf as it's faster an easier than 'find'
# Tell fd to follow symlinks and show hidden stuff except a few directories
export FZF_CTRL_T_COMMAND="fd ${FD_OPTS}"
export FZF_ALT_C_COMMAND="fd ${FD_OPTS} --type d"
export FZF_DEFAULT_COMMAND="${FZF_CTRL_T_COMMAND}"
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_OPTS="\
  --height 80% \
  --layout reverse \
  --multi \
  --cycle \
  --preview-window hidden:60%:wrap \
  --info inline \
  --bind 'shift-up:preview-page-up' \
  --bind 'shift-down:preview-page-down' \
  --bind 'ctrl-a:select-all' \
  --bind 'ctrl-o:execute(code {+})+cancel' \
  --bind '?:toggle-preview' \
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always --line-range :500 {} || cat {} | head -300)) || ([[ -d {} ]] && (tree -aC -I .git {} | less)) || echo {} 2> /dev/null | head -200' \
  "
