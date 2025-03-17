#!/bin/bash
if [[ $OSTYPE == "darwin"* ]]; then
    export PATH="$PATH:/Applications/Google Chrome.app/Contents/MacOS"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export GPG_TTY=$(tty) # required for macos gpg: https://gist.github.com/repodevs/a18c7bb42b2ab293155aca889d447f1b
    if [[ -z "$SSH_AUTH_SOCK" ]]; then 
        eval $(ssh-agent)
    fi
else
    if command -v xmodmap 1>/dev/null 2>&1 && [[ ! -z $DISPLAY ]] ; then
        xmodmap ~/.xmodmap
    fi
fi

if [[ "$WSL_DISTRO_NAME" ]]; then
    export BROWSER="wslview"
    export WINHOME="/mnt/c/Users/brendan"
    export GPG_TTY=$(tty)

    if [[ -z "$SSH_AUTH_SOCK" ]]; then 
        eval $(ssh-agent)
    fi
fi

export WD=$HOME/git/mx51
export WORKDIR=$HOME/git/mx51
export DOTS=$HOME/git/dotfiles

export EDITOR=nvim
export VISUAL=nvim
export PAGER="less -S"

# store some custom applications
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export GOPRIVATE="github.com/mx51/*"

# rust
[ -d "$HOME/.cargo" ] && export PATH="$PATH:$HOME/.cargo/bin" && . "$HOME/.cargo/env"

# python
if command -v pyenv 2>&1 >/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init --path - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm


# Clouds
export AWS_REGION="ap-southeast-2"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

