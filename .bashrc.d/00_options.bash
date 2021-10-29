## Bash specific options

# Append to history file, don't overwrite it
shopt -s histappend

# Update windows size after every command
shopt -s checkwinsize

### Directory Navigation
# autocorrect bad directory grammar
shopt -s cdspell
# prepend cd to directory names automatically
shopt -s autocd
# Correct spelling errors during tab-completion
shopt -s dirspell

### Globbing
# enable extended glob patterns
shopt -q -s extglob
# case insensisitve globbing (used for filename expansion)
shopt -s nocaseglob
# Turn on recursive globbong (enables ** to recurse all dirs)
shopt -s globstar

### Misc
# Add trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"
