showcsv() {

    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        echo -e "\033[1;34mUsage:\033[0m showcsv [\033[1;32mNUM_LINES\033[0m] [\033[1;33mFILENAME\033[0m]"
        echo -e "\033[1;34mDescription:\033[0m Show the first N lines of a CSV file with syntax highlighting."
        echo
        echo -e "\033[1;34mArguments:\033[0m"
        echo -e "  \033[1;32mNUM_LINES\033[0m  (optional) - Number of lines to display (default: 10)"
        echo -e "  \033[1;33mFILENAME\033[0m   (optional) - The CSV file to display (default: metadata.csv)"
        return 0       echo "Usage: showcsv [NUM_LINES] [FILENAME]"
    fi



    local file=${2:-metadata.csv}  # Default to 'metadata.csv' if no filename is given
    local lines=${1:-10}           # Default to 10 lines if no number is given

    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found!" >&2
        return 1
    fi

    echo "Showing first $lines lines of: $file"
    head -n "$lines" "$file" | bat --language=csv
}

dot() {
  # where your stow tree lives
  local root=${DOTFILES:-$HOME/.dotfiles}

  # pick one directory; fzf returns empty if you press Esc / Ctrl-C
  local dir
  dir=$(find "$root" -mindepth 1 -maxdepth 1 -type d | fzf) || return

  # nothing selected?  just return silently
  [[ -z $dir ]] && return

  # open the directory in your preferred editor
  "${EDITOR:-nvim}" "$dir"
}
