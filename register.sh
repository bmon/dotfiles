#!/usr/bin/env bash

FILENAME=${1/$HOME\/./}
LINKNAME="$HOME/.$FILENAME"

if [ ! -f $LINKNAME ]; then
    echo No such file exists: $LINKNAME
    exit 1
fi
if [ -f $FILENAME ]; then
    echo $FILENAME already exists in repository!
    exit 1
fi

echo "Registering $LINKNAME to dotfiles repository at $FILENAME"

# make any directories necessary to register the file
mkdir -p "$(dirname $FILENAME)"

# move the dotfile to repository dir
mv $LINKNAME $FILENAME

echo "Successfully copied file to dotfiles repo"

# link the dotfile back to the home directory
ln -s $(pwd)/$FILENAME $LINKNAME

echo "Successfully linked file in home dir"
echo "Committing changes..."

# add and commit the new file
git add $FILENAME
git commit -m "register $FILENAME"

echo "$FILENAME registered successfully!"
