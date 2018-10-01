#!/usr/bin/env bash

IGNORE=('install.sh' 'backup*')

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

    LINKNAME="$HOME/.$FILENAME"
    if [ $FILENAME -ef $LINKNAME ]; then
        echo -e "\e[2m$FILENAME already linked to $LINKNAME\e[0m"
        continue
    fi

    echo  -e "\e[94mInstalling $FILENAME to $LINKNAME\e[0m"

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
