# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/brendan.roy/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/brendan.roy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/brendan.roy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/brendan.roy/.fzf/shell/key-bindings.zsh"
