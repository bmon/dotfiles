#!/bin/bash
if [[ $OSTYPE == "darwin"* ]]; then
    export PATH="$PATH:/Applications/Google Chrome.app/Contents/MacOS"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    if command -v xmodmap 1>/dev/null 2>&1 && [[ ! -z $DISPLAY ]] ; then
        xmodmap ~/.xmodmap
    fi
fi

if [[ "$WSL_DISTRO_NAME" ]]; then
    export BROWSER="wslview"
    export WINHOME="/mnt/c/Users/brendan"
fi

#export GPG_TTY=$(tty)
#gpg-connect-agent updatestartuptty /bye >/dev/null
#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi

export WD=$HOME/git/12kmps
export DOTS=$HOME/git/dotfiles

export EDITOR=nvim
export VISUAL=nvim
export PAGER="less -S"
# store some custom applications
export PATH="$PATH:$HOME/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export GOPRIVATE="github.com/12kmps/*"

# rust
export PATH="$PATH:$HOME/.cargo/bin"

export AWS_REGION="ap-southeast-2"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
