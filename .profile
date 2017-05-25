export WORKON_HOME=~/.venv/
source /usr/bin/virtualenvwrapper.sh

#golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
