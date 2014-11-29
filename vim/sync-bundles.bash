#!/bin/bash

# Git submodules are annoying. Here's a vim bundle syncing script instead.

usage () {
    cat <<EOF

    $0 [BUNDLE-LIST] [BUNDLE-DIR]

    e.g:
        $ cat my-bundles
        vim-commentary   https://github.com/tpope/vim-commentary
        vim-fugitive     https://github.com/tpope/vim-fugitive
        vim-proc         https://github.com/Shougo/vimproc.vim    make
        # etc.
        $ $0 my-bundles ~/.vim/bundle
        # Dowloads any packages that aren't in the bundle dir, pulls any that
        # are.


    Notice the 'make' field in the input file? The script will also attempt to
    compile processes that need it.

EOF
}

if [ ! "$#" = 2 ]; then
    usage
    exit 3
fi

BUNDLES=$1
BUNDLE_DIR=$2

while read line; do
    read name bundle make <<< "$line"
    echo "Syncing $BUNDLE_DIR/$name to $bundle..."

    if [ -d "$BUNDLE_DIR"/"$name" ]; then
        (cd "$BUNDLE_DIR"/"$name" && git pull)
    else
        git clone "$bundle" "$BUNDLE_DIR"/"$name"
    fi

    if [ -n "$make" ]; then
        (cd "$BUNDLE_DIR"/"$name" && make)
    fi  

    echo
done < "$BUNDLES"
