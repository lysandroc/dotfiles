# !/bin/bash
ln -sfn ~/dotfiles/scripts/Brewfile ~/Brewfile
ln -sfn ~/dotfiles/scripts/.gitconfig ~/.gitconfig
ln -sfn ~/dotfiles/scripts/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/scripts/neovim.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/scripts/lua ~/.config/nvim/lua
ln -sfn ~/dotfiles/scripts/.tmux.conf ~/.tmux.conf

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

brew bundle install e --file=~/dotfiles/scripts/Brewfile

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 
asdf install nodejs 14.18.0
asdf global nodejs 14.18.0

source ~/.zshrc
