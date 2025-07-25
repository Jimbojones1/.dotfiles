source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
#
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#pyenv
eval "$(pyenv init -)"

eval "$(mise activate zsh --shims)"

# hooks detect directory changes and source/deactivate venvs
eval "$(mise activate zsh)"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export TERM=xterm-256color

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


alias lg='lazygit'
alias cd='z'
alias ls='eza --icons'
alias cat='bat'
alias fzp='fzf --preview "bat --color=always {} || cat {}"'
alias zkn="zk new --notebook-dir=$HOME/zettelkasten --working-dir=$HOME/zettelkasten -t "
alias fp="tmux-sessionizer"
alias zkdev="/Users/jameshaff/code/zk/zk"






ZSH_CUSTOM_FUNCTIONS_DIR="$HOME/.dotfiles/zsh/functions"

if [ -d "$ZSH_CUSTOM_FUNCTIONS_DIR" ]; then
  for file in $ZSH_CUSTOM_FUNCTIONS_DIR/*.zsh; do
    source "$file"
  done
fi




eval "$(zoxide init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Users/jameshaff/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
eval "$(mise activate zsh)"
export PATH="$PATH:$HOME/go/bin"
export GEMINI_API_KEY=AIzaSyBoe8eiANlMBuEAm4YsgvxxdMSrADBXJAY

# bind keys
zle -N fzfunc
bindkey '^t' fzfunc



