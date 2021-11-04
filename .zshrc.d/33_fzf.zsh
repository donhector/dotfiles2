# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
