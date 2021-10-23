# !/bin/bash
set -e

git clone -c core.eol=lf https://github.com/lysandroc/dotfiles ~/dotfiles
sudo chmod 644 ~/dotfiles/setup.sh
./dotfiles/setup.sh
