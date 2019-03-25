if [[ "$OSTYPE" == "darwin"* ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    export PATH="/Applications/Google Chrome.app/Contents/MacOS:$PATH"
    export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    #export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime
else
    if command -v xmodmap 1>/dev/null 2>&1; then
        xmodmap ~/.xmodmap
    fi
fi

# store some custom applications
export PATH="$PATH:$HOME/bin"

# yarn section
export PATH="$PATH:$(yarn global bin)"

# golang path changes
export GOPATH="$HOME/go"
export PATH="/usr/local/go/bin:$PATH:$GOPATH/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# fzf is a ctrl-r improvement https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.cargo/bin:$PATH"
