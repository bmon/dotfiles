#!/bin/bash

export DOTS=$HOME/git/dotfiles
export WD=$HOME/git

source "$HOME/.profile.$DOTS_PLATFORM"
source "$HOME/.profile.private"

export GNUPGHOME="$HOME/.config/gnupg-$DOTS_PLATFORM"

if [[ -z "$SSH_AUTH_SOCK" ]]; then 
    eval $(ssh-agent)
fi


export EDITOR=nvim
export VISUAL=nvim
export PAGER="less -S"
export LESS="-RFX" # Less options: -R interpret ANSI colors, -F quit if output fits on screen, -X don't clear screen on exit

# some custom applications
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# python
if command -v pyenv 2>&1 >/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init --path - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

# java
if command -v jenv 2>&1 >/dev/null; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Clouds
export AWS_REGION="ap-southeast-2"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi
