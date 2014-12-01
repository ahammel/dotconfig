#!/bin/bash

usage () {
    cat <<EOF

    $0 [PKG-LIST]

    Runs a simple cabal-install on all the packages listed in the PKG-LIST

EOF
}

if [ "$#" != 1 ]; then
    usage
    exit 3
fi

PKG_LIST=$1
PACKAGES=$(tr "\\n" " " <"$PKG_LIST")

echo "Packages to be installed:"
echo "$PACKAGES"
read -p "OK? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cabal update
    cabal install $PACKAGES
    exit
else
    echo "Bailing out..."
    exit
fi

