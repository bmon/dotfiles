#!/bin/sh
ls -a | grep -e "^\.\w" | grep -v "^\.git$" | xargs -I % cp -v -r ~/% .

