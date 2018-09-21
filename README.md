# brendan's dotfiles
installation: `./install.sh`

This will install all non-hidden files (except the install script, and the backup folder)
to your `$HOME`, using symlinks to the dotfiles repository. It will back up your existing
dotfiles to `backup` if they would be overwritten.

Please not this is not a complete install. You may still need to install:

- vim and run `:PlugInstall`
- oh-my-zsh
- tmux
- ripgrep
