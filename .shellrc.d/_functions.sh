# make a backup of a file
function bak {
	cp -av "$1" "${1}_$(date --iso-8601=seconds).bak"
}

# make a dir and cd into it
function mkcd {
    mkdir -p "$@" || return
    shift $(( $# - 1)) 
    cd "$1"
}

# make temp dir and cd into it
function mkcdtmp {
	cd "$( mktemp -d )";
}

# change dir and show contents
function cdls() { cd "$@" && ls -Fa --color=auto; }

## Colored output for scripts
# colored echo
function cecho {
    color=$1
    shift
    echo -e "${color}${@}${NO_COLOR}"
}

function error {
    cecho $RED "ERROR: ${@}"
}

function fatal {
    cecho $RED "FATAL: ${@}"
}

function warn {
    cecho $YELLOW "WARN: ${@}"
}

function info {
    cecho $NO_COLOR "INFO: ${@}"
}

function success {
    cecho $GREEN "SUCCESS: ${@}"
}

function debug {
    cecho $DARK_GRAY "DEBUG: ${@}"
}

function highlight {
    cecho $CYAN "${@}"
}


# Extract an archive
function extract() {
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
function compress() {
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
function myip {
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
function google {
	xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`"
}

# Encode with URLEncode
function urlencode {
	python -c "import sys; from urllib.parse import quote_plus; print(quote_plus(sys.stdin.read()))"
}

# Decode URLencoded string
function urldecode {
	python -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()), end='')"
}

# Convert a querystring into pretty JSON
function urlarray {
	python -c "import sys, json; from urllib.parse import parse_qs; print(json.dumps({k: q[0] if len(q) == 1 else q for k, q in parse_qs(sys.stdin.read()).items()}), end='')" | json
}

# print a separator banner, as wide as the terminal
function hr {
	printf "=%.0s" $(seq $COLUMNS)
}

# Useful when running under WSL2 to resolve windows variables such as "%APPDATA%"
function get_win_var {
    cmd.exe /c "echo ${1}" 2> /dev/null | sed -e 's/\r//g'
}
