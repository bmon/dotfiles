THEME="p10k"

case "$THEME" in
    # powerlevel10k is quite a neat and powerful terminal theme
    # however it adds about 180ms of latency to a zsh startup
    p10k)
        source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
        POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
        POWERLEVEL9K_STATUS_OK=false
        POWERLEVEL9K_PROMPT_ON_NEWLINE=true
        POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
        POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
        ;;
    # agnoster is a much more basic version (in fact the inspiration)
    # for powerlevel9k/10k and is way faster to load.
    agnoster)
        source ~/.zsh/agnoster-zsh-theme/agnoster.zsh-theme
        setopt promptsubst
        typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
        prompt_status
        prompt_context
        prompt_virtualenv
        prompt_dir
        prompt_git
        prompt_end
        )
        ;;
esac

# zsh-autosuggestions (press ctrl-space to load)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-execute #ctrl-space to execute suggestion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244,underline"

# fzf is a ctrl-r improvement https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source profile and aliases
source ~/.profile
source ~/.aliases

# zsh history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_ignore_all_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data


# launch tmux if not already running.
if [[ -z "$TMUX" ]]; then
    tmux -2 new-session -As main
    tmux has-session &> /dev/null
    if [ $? -eq 1 ]; then
        echo "Tmux was killed, dropping back to zsh"
    fi
fi
