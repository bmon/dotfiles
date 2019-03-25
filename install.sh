#!/usr/bin/env bash

IGNORE=('install.sh' 'README.md' 'register.sh' 'backup*')
NO_DOT=('bin*')

containsElement () {
  local e match="$1"
  shift
  for e; do [[ $match == $e ]] && return 0; done
  return 1
}

# make the backup dir if it doesn't exist
mkdir -p backup

for FILENAME in $(find * -type f); do
    # ignore certain files and folders in the repo
    if containsElement $FILENAME "${IGNORE[@]}" ; then
        echo $FILENAME ignored.
        continue
    fi

    # create and store the file path for the new link
    LINKNAME="$HOME/.$FILENAME"
    if containsElement $FILENAME "${NO_DOT[@]}" ; then
        # allow some files (or directories) to be stored without a dot
        LINKNAME="$HOME/$FILENAME"
    fi

    if [ $FILENAME -ef $LINKNAME ]; then
        printf "$(tput setaf 10)$FILENAME already linked to $LINKNAME$(tput sgr0)\n"
        continue
    fi

    printf "$(tput setaf 4)Installing $FILENAME to $LINKNAME$(tput sgr0)\n"

    if [ -e $LINKNAME ]; then
      # make a backup of the file(s), with a confirm override if necessary
      mkdir -p "$(dirname backup/$FILENAME)"
      mv -i "$LINKNAME" "backup/$FILENAME"
    fi
    # make any directories necessary to install the link
    mkdir -p "$(dirname $LINKNAME)"
    # link the dotfile to the home directory
    ln -s $(pwd)/$FILENAME $LINKNAME
done
