#!/usr/bin/env sh

### Setup fzf (fuzzy finder)

function install_fzf {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function update_fzf {
	cd ~/.fzf && git pull && ./install
}

function uninstall_fzf {
	cd ~/.fzf && ./uninstall
}

### Install fzf if not present

[ ! -d ~/.fzf ] && install_fzf


### Customize fzf settings

fzf_compgen_path() {
  fd --exclude ".git" --follow --hidden . "$1"
}

fzf_compgen_dir() {
  fd --exclude ".git" --follow --hidden --type d . "$1"
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
# Tell fd to follow symlinks and show hidden stuff except .git directories
FD_OPTS="--hidden --follow --exclude .git --exclude node_modules"
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

### Here's a list of extra previews to be used by the fzf-tab plugin

# Preview systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 sudo systemctl status $word'

# Preview contents of variables export, unset
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# Preview process details for 'kill' and 'ps' commands
zstyle ':completion:*:*:*:*:processes' command "\ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && \ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
