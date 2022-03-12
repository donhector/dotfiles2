# make a backup of a file
bak() {
	cp -av "$1" "${1}_$(date --iso-8601=seconds).bak"
}

# make a dir and cd into it
mkcd() {
    mkdir -p "$@" || return
    shift $(( $# - 1)) 
    cd "$1"
}

# make temp dir and cd into it
mkcdtmp() {
	cd "$( mktemp -d )";
}

# change dir and show contents
cdls() { cd "$@" && ls -Fa --color=auto; }

## Colored output for scripts
# colored echo
cecho() {
    color=$1
    shift
    echo -e "${color}${@}${NO_COLOR}"
}

error() {
    cecho "$RED" "ERROR: ${@}"
}

fatal() {
    cecho "$RED" "FATAL: ${@}"
}

warn() {
    cecho "$YELLOW" "WARN: ${@}"
}

info() {
    cecho "$NO_COLOR" "INFO: ${@}"
}

success() {
    cecho "$GREEN" "SUCCESS: ${@}"
}

debug() {
    cecho "$DARK_GRAY" "DEBUG: ${@}"
}

highlight() {
    cecho "$CYAN" "${@}"
}


# Extract an archive
extract() {
    if [ -z "$2" ]; then 2="."; fi
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2|*.tbz2|*.tbz)       mkdir -v "$2" 2>/dev/null ; tar xvjf "$1" -C "$2"  ;;
            *.tar.gz|*.tgz)               mkdir -v "$2" 2>/dev/null ; tar xvzf "$1" -C "$2"  ;;
            *.tar.xz)                     mkdir -v "$2" 2>/dev/null ; tar xvJf "$1"          ;;
            *.tar)                        mkdir -v "$2" 2>/dev/null ; tar xvf  "$1" -C "$2"  ;;
            *.rar)                        mkdir -v "$2" 2>/dev/null ; unrar x  "$1"          ;;
            *.zip)                        mkdir -v "$2" 2>/dev/null ; unzip    "$1" -d "$2"  ;;
            *.7z)                         mkdir -v "$2" 2>/dev/null ; 7z x     "$1" -o"$2"   ;;
            *.lzo)                        mkdir -v "$2" 2>/dev/null ; lzop -d  "$1" -p "$2"  ;;
            *.gz)                         gunzip "$1"                                        ;;
            *.bz2)                        bunzip2 "$1"                                       ;;
            *.Z)                          uncompress "$1"                                    ;;
            *.xz|*.txz|*.lzma|*.tlz)      xz -d "$1"                                         ;;
            *)
        esac
    else
        echo "Sorry, '$1' could not be decompressed."
        echo "Usage: extract <archive> <destination>"
        echo "Example: extract PKGBUILD.tar.bz2 ."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.xz, tar, bz2,"
        echo "gz, tbz2, tbz, tgz, lzo,"
        echo "rar, zip, 7z, xz and lzma"
    fi
}

# compress a file or folder
compress() {
	if [ -z "$2" ]; then 2="."; fi
    case "$1" in
        tar.bz2|.tar.bz2) tar cvjf "${2%%/}.tar.bz2" "${2%%/}/" ;;
        tbz2|.tbz2)       tar cvjf "${2%%/}.tbz2" "${2%%/}/"    ;;
        tbz|.tbz)         tar cvjf "${2%%/}.tbz" "${2%%/}/"     ;;
        tar.xz)           tar cvJf "${2%%/}.tar.xz" "${2%%/}/"  ;;
        tar.gz|.tar.gz)   tar cvzf "${2%%/}.tar.gz" "${2%%/}/"  ;;
        tgz|.tgz)         tar cvjf "${2%%/}.tgz" "${2%%/}/"     ;;
        tar|.tar)         tar cvf  "${2%%/}.tar" "${2%%/}/"     ;;
        rar|.rar)         rar a "${2}.rar" "$2"                 ;;
        zip|.zip)         zip -r -9 "${2}.zip" "$2"             ;;
        7z|.7z)           7z a "${2}.7z" "$2"                   ;;
        lzo|.lzo)         lzop -v "$2"                          ;;
        gz|.gz)           gzip -r -v "$2"                       ;;
        bz2|.bz2)         bzip2 -v "$2"                         ;;
        xz|.xz)           xz -v "$2"                            ;;
        lzma|.lzma)       lzma -v "$2"                          ;;
        *)                echo "Compress a file or directory."
        echo "Usage:   compress <archive type> <filename>"
        echo "Example: ac tar.bz2 PKGBUILD"
        echo "Please specify archive type and source."
        echo "Valid archive types are:"
        echo "tar.bz2, tar.gz, tar.gz, tar, bz2, gz, tbz2, tbz,"
        echo "tgz, lzo, rar, zip, 7z, xz and lzma." ;;
    esac
}

# get host ip
myip() {
	local api
	case "$1" in
		"-4")
			api="http://v4.ipv6-test.com/api/myip.php"
			curl -s "$api"
			echo
			;;
		"-6")
			api="http://v6.ipv6-test.com/api/myip.php"
			curl -s "$api"
			echo
			;;
		"-l"|"-p") 
			hostname -I
			;;
		*)
			api="http://ipv6-test.com/api/myip.php"
			echo "Public: $(curl -s $api)"
			echo "Private: $(hostname -I)"
			;;
	esac

}

# open a web browser on google for a query
google() {
	xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`"
}

# Encode with URLEncode
urlencode() {
	python -c "import sys; from urllib.parse import quote_plus; print(quote_plus(sys.stdin.read()))"
}

# Decode URLencoded string
urldecode() {
	python -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()), end='')"
}

# Convert a querystring into pretty JSON
urlarray() {
	python -c "import sys, json; from urllib.parse import parse_qs; print(json.dumps({k: q[0] if len(q) == 1 else q for k, q in parse_qs(sys.stdin.read()).items()}), end='')" | json
}

# print a separator banner, as wide as the terminal
hr() {
	printf "-%.0s" $(seq $COLUMNS)
}

# Download audio from the given Youtube video or playlist URL
ytmp3() {
    command -v yt-dlp >/dev/null 2>&1 || pip install --user yt-dlp
    command -v ffmpeg >/dev/null 2>&1 || sudo apt install -y -qq --no-install-recommends ffmpeg
    local URL="${1:?'Error: URL to video or playlist must be provided'}"
    yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --download-archive catalog.txt "$URL"
}

# Enhanced git diff using bat
gitdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

# Interactively get latest release assest(s) from Github (fzf powered)
gdlr() {
    local project="${1:?'User/repo combination must be provided. Ex: sharkdp/fd'}"
    curl -s https://api.github.com/repos/"${project}"/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | fzf -m | wget -i -
}

# Enhanced tail -f output
tailf() {
    tail -f "$@" | bat --paging=never -l log
}

# Intereactively select the process(es) to kill
killz() {
    ps -f | fzf --reverse -m --preview-window=down:4:wrap | awk '{print $2}' | xargs kill -9
}

# Interactively find text in files. Supports context preview and opening the match in vscode
fif() {
    rg  \
    --column \
    --no-heading \
    --fixed-strings \
    --ignore-case \
    --hidden \
    --follow \
    --glob '!.git/*' \
    --glob '!.vscode-server/*' \
    "$1" \
    | awk -F  ":" '/1/ {start = $2<5 ? 0 : $2 - 5; end = $2 + 5; print $1 " " $2 " " $3 " " start ":" end}' \
    | fzf \
        --bind 'ctrl-o:execute(code --goto {1}:{2}:{3})+cancel' \
        --preview 'bat --wrap character --color always {1} --highlight-line {2} --line-range {4}' \
        --preview-window wrap
}

aptz() {
    apt-cache search '' | sort | cut --delimiter ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xargs -r sudo apt install -y
}

# Better man pages for the given command
help() {
    curl cheat.sh/"$1"
}

# Replace text in files
# Usage: replace 'foo' 'bar'
replace() {
    rg "$1" --files-with-matches | xargs sed -i "s/$1/$2/g"
}

# Interactively install software using asdf
# First you can fzf the plugin to install, then you can fzf the version to install
# Version is sorted from newer to lower (ie: --tac)
# % is the selected plugin
# @ is the selected version
# {} is the selected version mode (one of "global" "local" "shell")
asdfi(){
    asdf plugin-list-all | cut -d ' ' -f1 | fzf --cycle --reverse | \
        xargs -r -I% sh -c \
            "asdf plugin add % || true && asdf list-all % | fzf --tac | xargs -r -I@ sh -c \
            'asdf install % @ && printf \"global\nlocal\nshell\" | fzf | xargs -r -I{} asdf {} % @ \
            && asdf reshim %'"
}
