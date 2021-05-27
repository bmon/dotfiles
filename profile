#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    export PATH="$PATH:/Applications/Google Chrome.app/Contents/MacOS"
    export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    export PATH="$PATH:/usr/local/opt/mysql-client/bin:"
    #export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime
else
    if command -v xmodmap 1>/dev/null 2>&1 && [[ -v $DISPLAY ]] ; then
        xmodmap ~/.xmodmap
    fi

    #eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK

    #alias open=xdg-open
fi
if [[ "$WSL_DISTRO_NAME" ]]; then
    export BROWSER="wslview"
    # gpg on wsl https://stackoverflow.com/a/55032706
    export GPG_TTY=$(tty)
fi


export DOTS=$HOME/git/dotfiles
# work
export AP=$HOME/git/mx51
export WORKDIR=$AP
export OPERATOR_USER_DETAILS="email=brendan+admins@mx51.io;mobile_number=0429107503;first_name=brendan;last_name=roy"
export MERCHANT_USER_DETAILS="email=brendan+merchant-admins@mx51.io;mobile_number=0429107503;first_name=brendan;last_name=roy"

export EDITOR=nvim
export VISUAL=nvim
export PAGER="less -S"
# store some custom applications
export PATH="$PATH:$HOME/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export GOPRIVATE="github.com/mx51/*,github.com/AssemblyPayments/*"

# rust
export PATH="$PATH:$HOME/.cargo/bin"

if [[ -f "$HOME/.okta/bash_functions" ]]; then
    . "$HOME/.okta/bash_functions"
fi
if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
    PATH="$HOME/.okta/bin:$PATH"
fi

export AWS_REGION="ap-southeast-2"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
