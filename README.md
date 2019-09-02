# brendan's dotfiles
installation: `./install_deps.sh && ./install.sh`

`install_deps.sh` will install some required addons - except for anything that could/should
be reasonably installed by your OS's package manager. It will warn you if you are missing some
required pagkages (like nvim).

`install.sh` will install all non-hidden files (except the backup folder, and some select
ignored files, see `install.sh` for a complete list) to your `$HOME`, using symlinks to the
dotfiles repository. It will back up your existing dotfiles to `backup` if they would
be overwritten.

You can easily add new files to the repository by running `./register.sh ~/.some/file` from
the root of the dotfiles repository. This will copy the specified file to the dotfiles
repo, link it back to your `$HOME`, and commit the file. If you need to register a file that
doesn't start with a dot, the easiest way is to update the `NO_DOT` array in `install.sh`, copy
the file/directory to the dotfiles repo then run `install.sh` to link it back to the original
location.

Please note that the current implementation of the `install.sh` and `register.sh` scripts
requires that all files must be hidden in the home directory (i.e all paths must look like
`~/.somefile` or `~/.some/file/under/a/hidden/directory`). This allows me to version the
dotfiles as non-hidden versions of themselves, which makes things a little easier. If you
want to add a non-hidden file to your _"dotfiles"_ repo, you could install as normal them `mv`
the link after the install is done.
