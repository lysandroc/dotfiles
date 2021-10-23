# !/bin/bash
ln -sfn ~/dotfiles/.dotfiles/Brewfile ~/Brewfile
ln -sfn ~/dotfiles/.dotfiles/.gitconfig ~/.gitconfig
ln -sfn ~/dotfiles/.dotfiles/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/.dotfiles/neovim.vim ~/.config/nvim/init.vim
ln -sfn ~/dotfiles/.dotfiles/lua ~/.config/nvim/lua
ln -sfn ~/dotfiles/.dotfiles/.tmux.conf ~/.tmux.conf

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

brew bundle install

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 
asdf install nodejs 14.18.0
asdf global nodejs 14.18.0

source ~/.zshrc