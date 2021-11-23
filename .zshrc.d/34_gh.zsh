## Load completions

gh completion -s zsh | sudo dd status=none of=/usr/local/share/zsh/site-functions/_gh
autoload -Uz compinit && compinit -i
