# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/brendanroy/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/brendanroy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/brendanroy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/brendanroy/.fzf/shell/key-bindings.zsh"

