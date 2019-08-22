if [[ "$OSTYPE" == "darwin"* ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    export PATH="$PATH:/Applications/Google Chrome.app/Contents/MacOS"
    export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    export PATH="$PATH:/usr/local/opt/mysql-client/bin:"
    #export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime

    source $(brew --prefix php-version)/php-version.sh && php-version 5
else
    if command -v xmodmap 1>/dev/null 2>&1; then
        xmodmap ~/.xmodmap
    fi
fi

export VISUAL=nvim
# store some custom applications
export PATH="$PATH:$HOME/bin"

# teh script
export PATH="$PATH:$(yarn global bin)"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# rust
export PATH="$PATH:$HOME/.cargo/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# fzf is a ctrl-r improvement https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
