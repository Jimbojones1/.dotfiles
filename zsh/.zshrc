# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(pyenv init -)"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export TERM=xterm-256color




alias lg='lazygit'
alias cd='z'
alias ls='eza --icons'
alias cat='bat'

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


eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Users/jameshaff/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"

