# Brendan's zshrc.
# This file should contain zsh specific configuration, and should also source any generic
# configuration files such as ~/.aliases. Lastly it will connect to an existing tmux session,
# or start the server if there is none.
#
# One of my primary aims is to keep this file as fast as possible, to reduce startup time when
# creating tmux panes. This is the reason I don't use oh-my-zsh, for example. I've actually
# found switching away from oh-my-zsh to be pretty simple.


THEME="p10k"

case "$THEME" in
    # powerlevel10k is quite a neat and powerful terminal theme
    # however it adds about 180ms of latency to a zsh startup
    p10k)
        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
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

bindkey -e # don't use vi mode terminal

# zsh-autosuggestions (press ctrl-space to load)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-execute #ctrl-space to execute suggestion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244,underline"

# fzf is a ctrl-r improvement https://github.com/junegunn/fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
command -v fzf > /dev/null && source <(fzf --zsh)

# source profile and aliases
source ~/.profile
source ~/.profile.private
source ~/.aliases

# zsh history
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt extended_history
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
setopt interactivecomments # allow comments on shell


# https://wiki.archlinux.org/index.php/Zsh#Key_bindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# launch tmux if not already running.
if [[ -z "$TMUX" ]]; then
    tmux -2 new-session -As main
    tmux has-session &> /dev/null
    if [ $? -eq 1 ]; then
        echo "Tmux was killed, dropping back to zsh"
    fi
fi
