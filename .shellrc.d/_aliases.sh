### SHELL agnostic aliases
 
# ls aliases
alias l="ls -CF"
alias ll="ls -lh"
alias la="ls -lAh"
alias sl="ls"
alias lt='ls --human-readable --size -1 -S --classify'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# Process related aliases
alias k9='kill -9'
alias ps='ps -aux'
alias psf='ps -faux'
alias ns='netstat -tulpn'
alias j='jobs -l'

alias sudo='sudo ' ## Allow aliases to be sudo’ed
alias watch='watch ' ## Allow aliases to be watched

# Time and date aliases
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Show PATH as lines
alias path='echo -e ${PATH//:/\\n}'

# File related
alias mkdir='mkdir -pv'
alias rmr='rm -rf'
alias cpv='rsync -ah --info=progress2'
alias mountc='mount | column -t'

# history grep
alias hg='history|grep'

# find related
alias count='find . -type f | wc -l'

# octal+text permissions for files
alias perms="stat -c '%A %a %n UID (%u/%U) GID (%g/%G)'"

# Make unified diff syntax the default
alias diff="diff --color -u"

alias tailf='tail -f'
alias df='df -Ph'
alias du='du -h'
alias open='xdg-open'
alias update='sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove'

# APT aliases
alias apt-search='apt-cache search'
alias apt-madison='apt-cache madison'

# Tar aliases
alias targz='tar -czpvf'
alias tarxz='tar -cJpvf'
alias tarbz2='tar -cjpvf'
alias untargz='tar -xzvf'
alias untarxz='tar -xJvf'
alias untarbz2='tar -xjvf'

## Python aliases
alias py='python3'
# Run web server
alias http='python3 -m http.server 8080'
# Prettify JSON:
alias json="python3 -m json.tool"
# Convert yaml to pretty JSON:
alias yaml="python3 -c 'import json, sys, yaml; y=yaml.safe_load(sys.stdin.read()); print(json.dumps(y, indent=4))'"

# Download audio from Youtube
alias ymp3="youtube-dl --extract-audio --audio-format mp3"

# Speed test
alias speedtest='wget -O /dev/null http://speedtest.london.linode.com/100MB-london.bin'

# Useful SSH Key aliases
alias keys='for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
alias keypair="ssh-keygen -t ed25519 -C ${USER}@${HOST}"


if [ -n "$WSL_DISTRO_NAME" ]; then
    echo "Loading WSL specific aliases..."
    # This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
    # up memory, this command will free your memory after about 20-30 seconds.
    #   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
    alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
    alias open="explorer.exe ."
    alias browse="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"
fi
