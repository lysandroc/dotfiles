# !/bin/bash
set -e

git clone -c core.eol=lf https://github.com/lysandroc/dotfiles ~/dotfiles
bash ~/dotfiles/setup.sh
