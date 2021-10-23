#!/bin/bash
set -e

mkdir -p "$HOME/dotfiles" && 
git clone https://github.com/lysandroc/dotfiles "$HOME/dotfiles" &&
chmod g-rwX "$HOME/dotfiles" &&
"./$HOME/dotfiles/setup.sh"


