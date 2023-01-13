# ==== Basic

# cd into dir without typing cd
setopt AUTO_CD

# ==== History

# share history across multiple zsh sessions
setopt SHARE_HISTORY

# append to history
setopt APPEND_HISTORY

# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST

# ensure no dupes also in the history file (not just in memory)
setopt HIST_IGNORE_ALL_DUPS

# ensure no command is saved when the first character on the line is a space
setopt HIST_IGNORE_SPACE

# ===== Completion 

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD 

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

# ===== Prompt

# Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt PROMPT_SUBST

unsetopt MENU_COMPLETE
setopt AUTO_MENU
