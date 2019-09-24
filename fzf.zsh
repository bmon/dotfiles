# Setup fzf
# ---------
if [[ ! "$PATH" == */home/broy/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/broy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/broy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/broy/.fzf/shell/key-bindings.zsh"
