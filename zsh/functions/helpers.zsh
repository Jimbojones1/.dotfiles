# ~/.config/zsh/functions/fzf_helpers.zsh

# Use fzf to browse and select a user-defined function from your custom files
fzfunc() {
  local ZSH_CUSTOM_FUNCTIONS_DIR="$HOME/.dotfiles/zsh/functions"
  
  if [ ! -d "$ZSH_CUSTOM_FUNCTIONS_DIR" ]; then
    echo "Custom functions directory not found: ${ZSH_CUSTOM_FUNCTIONS_DIR}" >&2
    return 1
  fi

  # Parse function names directly from your custom .zsh files, then pipe to fzf
  local selected_func
  selected_func=$(grep -h '^[a-zA-Z0-9_-]\+()' $ZSH_CUSTOM_FUNCTIONS_DIR/*.zsh | sed 's/().*//' | grep -v '^fzfunc$' | fzf)

  # If a function was selected...
  if [[ -n "$selected_func" ]]; then
    # Place it in the command-line buffer
    zle -U "$selected_func"
  fi
}
