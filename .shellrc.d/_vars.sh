### SHELL agnostic vars

# Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BROWN=$(tput setaf 3)
ORANGE=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
LIGHT_GRAY=$(tput setaf 7)
DARK_GRAY=$(tput setaf 8)
LIGHT_RED=$(tput setaf 9)
LIGHT_GREEN=$(tput setaf 10)
YELLOW=$(tput setaf 11)
LIGHT_BLUE=$(tput setaf 12)
LIGHT_PURPLE=$(tput setaf 13)
LIGHT_CYAN=$(tput setaf 14)
WHITE=$(tput setaf 15)
NO_COLOR=$(tput sgr0) # No Color
DEFAULT_COLOR=${NO_COLOR}

# Default editor
EDITOR=vim

# Automatically trim long paths in the prompt
PROMPT_DIRTRIM=2

# Record each line as it gets entered
PROMPT_COMMAND='history -a'

# History settings
HISTSIZE=1000000
HISTFILESIZE=1000000
