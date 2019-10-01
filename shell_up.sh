#!/bin/bash
DEPENDANCIES=('bash' 'zsh' 'tmux' 'nvim' 'rg')
FONT_PREF="Hasklig"

echo_cmd() {
    tput setaf 4
    echo \$ $1
    tput sgr0
}


# ============= DEPS =============
printf "$(tput setaf 4)checking dependancies...$(tput sgr0)\n"
deps_ok=1
for dep in "${DEPENDANCIES[@]}" ; do
    if ! [ -x "$(command -v $dep)" ] ; then
        deps_ok=0
        printf "$(tput setaf 1)error: required dependancy $(tput smul)$dep$(tput rmul) was unable to be located $(tput sgr0)\n"
    fi
done
if ! [ "$deps_ok" -eq 1 ] ; then
    echo "Aborting. Please install all missing dependancies, and try again."
    exit 1
fi

# ============= SHELL PLUGINS =============
printf "$(tput setaf 4)installing zsh plugins...$(tput sgr0)\n"

echo_cmd "git -C ~/.zsh/powerlevel10k pull || git clone https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k"
git -C ~/.zsh/powerlevel10k pull || git clone https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k

echo_cmd "git -C ~/.zsh/agnoster-zsh-theme pull || git clone https://github.com/agnoster/agnoster-zsh-theme ~/.zsh/agnoster-zsh-theme"
git -C ~/.zsh/agnoster-zsh-theme pull || git clone https://github.com/agnoster/agnoster-zsh-theme ~/.zsh/agnoster-zsh-theme

echo_cmd "git -C ~/.zsh/zsh-autosuggestions || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions"
git -C ~/.zsh/zsh-autosuggestions pull || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


# ============= FONTS =============
printf "$(tput setaf 4)installing patched fonts...$(tput sgr0)\n"
if cd ~/git/nerd-fonts 2>/dev/null ; then
    echo_cmd "git pull"
    git pull
else
    printf "$(tput setaf 4)downloading font repository (this may take a while)...$(tput sgr0)\n"
    echo_cmd "git clone gh:ryanoasis/nerd-fonts --depth 1"
    git clone gh:ryanoasis/nerd-fonts ~/git/nerd-fonts --depth 1
    cd ~/git/nerd-fonts
fi

echo_cmd "./install.sh $FONT_PREF 2>install_err"
./install.sh -C $FONT_PREF 2>install_err | while read -r line ; do
    printf "."
done
printf "\n"
if [ -s install_err ] ; then
    tput setaf 1
    echo "Errors were encountered during font installation."
    echo "You should confirm the specified fonts were correctly installed."
    cat install_err
    tput sgr0
fi
cd $OLDPWD
printf "$(tput setaf 4)font $(tput bold)$FONT_PREF$(tput dim) installed$(tput sgr0)\n"


# ============= VIM PLUGINS =============
printf "$(tput setaf 4)installing vim plugins...$(tput sgr0)\n"
echo_cmd "nvim -E -c PlugInstall -c qa"
nvim -E -c PlugInstall -c qa
