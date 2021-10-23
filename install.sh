# !/bin/bash
set -e

git clone -c core.eol=lf https://github.com/lysandroc/dotfiles ~/dotfiles
cd ~/dotfiles
chmod 644 setup.sh
./setup.sh
