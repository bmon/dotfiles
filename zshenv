# History settings live in zshenv (not zshrc) so they apply to ALL zsh
# invocations, including non-interactive subshells (e.g. `zsh -c ...` spawned
# by tools like Claude Code). Without this, those subshells default to
# HISTSIZE=30 and SAVEHIST=0, which can truncate ~/.zsh_history if anything
# triggers a history write from such a subshell.
#
# This file is ALSO sourced from the top of ~/.zshrc, because macOS's
# /etc/zshrc runs AFTER ~/.zshenv and resets HISTSIZE=2000, SAVEHIST=1000.
# Re-sourcing in zshrc restores our values for interactive shells.
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export HISTFILE HISTSIZE SAVEHIST
