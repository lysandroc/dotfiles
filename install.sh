# !/bin/bash
set -e

git clone -c core.eol=lf https://github.com/lysandroc/dotfiles ~/dotfiles
chmod -x ~/dotfiles/setup.sh
./dotfiles/setup.sh
