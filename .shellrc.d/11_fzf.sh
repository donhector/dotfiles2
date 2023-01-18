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

# My custom fd folder exclusions
EXCLUDE_ARGS='-E .git -E node_modules -E .npm -E .cache -E .vscode-server -E .venv -E .local'

# Default fd options
# - Show hidden files
# - Follow symlinks
# - Exclude certain folders regardless of .gitignore presence 
FD_OPTS="--hidden --follow ${EXCLUDE_ARGS}"

# Setting fd as the default source for fzf as it's faster an easier than 'find'
# Tell fd to follow symlinks and show hidden stuff except a few directories
export FZF_DEFAULT_COMMAND="fd ${FD_OPTS}"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"
export FZF_COMPLETION_TRIGGER='**'
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


# Configure fzf to use 'fd' instead of the slower 'find' for file and directory searches 
fzf_compgen_path() {
  fd "${FD_OPTS}" . "$1"
}

# Configure fzf to use 'fd' instead of the slower 'find' for directory searches 
fzf_compgen_dir() {
  fd "${FD_OPTS}" --type d . "$1"
}
