# ZSH specific aliases

# Ensure adding timestamp to history commands
alias history='history -i'
alias fc="fc -i"

# Global alias to pipe to fzf. ie 'ls Z'
alias -g Z='| fzf'
