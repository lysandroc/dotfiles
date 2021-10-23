#!/bin/bash
set -e

command mkdir -p "$HOME/dotfiles" && command chmod g-rwX "$HOME/dotfiles"
command git clone https://github.com/lysandroc/dotfiles "$HOME/dotfiles"
"./$HOME/dotfiles/setup.sh"


