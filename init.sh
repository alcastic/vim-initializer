#!/usr/bin/bash

set -e

# Check if 'vim' is installed on the System
if ! command -v vim &> /dev/null
then
    echo "'vim' command not found"
    exit
fi

# Check if 'curl' is installed on the System
if ! command -v curl &> /dev/null
then
    echo "'curl' command not found"
    exit
fi

echo '##################################################################################'
echo '    ____                     ___     __                          __     _         '
echo '   / __ )   __  __          /   |   / /  _____  ____ _   _____  / /_   (_)  _____ '
echo '  / __  |  / / / /         / /| |  / /  / ___/ / __ `/  / ___/ / __/  / /  / ___/ '
echo ' / /_/ /  / /_/ /         / ___ | / /  / /__  / /_/ /  (__  ) / /_   / /  / /__   '
echo '/_____/   \__, /         /_/  |_|/_/   \___/  \__,_/  /____/  \__/  /_/   \___/   '
echo '         /____/                                                                   '
echo '##################################################################################'
echo 'Applying custom vim configuration'

VIMRC_FILE=~/.vimrc
VIMRC_BACKUP_FILE="$VIMRC_FILE.backup"

if test -f "$VIMRC_FILE"; then
    echo "File $VIMRC_FILE already exists!"
    if test -f "$VIMRC_BACKUP_FILE"; then
        echo "$VIMRC_BACKUP_FILE detected! configuration aborted"
        exit
    else
        echo "Backing file $VIMRC_FILE into $VIMRC_BACKUP_FILE"
        cp $VIMRC_FILE $VIMRC_BACKUP_FILE
        echo "File $VIMRC_FILE successfully backed into $VIMRC_BACKUP_FILE"
    fi
fi

echo "Creating new $VIMRC_FILE vim configuration file"
cat <<EOT > $VIMRC_FILE
" Add numbers to each line on the left-hand side.
set number

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Turn syntax highlighting on.
syntax on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight max number of characters recomended per line
:set colorcolumn=80

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" Cursor Shape
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

EOT
echo "Vim configuration file $VIMRC_FILE created successfully"
