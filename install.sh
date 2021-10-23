#!/bin/bash
set -e

mkdir -p "$HOME/dotfiles"
git clone https://github.com/lysandroc/dotfiles "$HOME/dotfiles"
chmod 644 "$HOME/dotfiles/setup.sh"

echo "Installing"
"./dotfiles/setup.sh"
