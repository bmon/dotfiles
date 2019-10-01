if [[ "$OSTYPE" == "darwin"* ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    export PATH="$PATH:/Applications/Google Chrome.app/Contents/MacOS"
    export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    export PATH="$PATH:/usr/local/opt/mysql-client/bin:"
    #export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime
else
    if command -v xmodmap 1>/dev/null 2>&1; then
        xmodmap ~/.xmodmap
    fi
fi

export VISUAL=nvim
# store some custom applications
export PATH="$PATH:$HOME/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# rust
export PATH="$PATH:$HOME/.cargo/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
