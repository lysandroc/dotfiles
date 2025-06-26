# !/bin/bash
ln -sfn ~/dotfiles/scripts/Brewfile ~/Brewfile
ln -sfn ~/dotfiles/scripts/.gitconfig ~/.gitconfig
ln -sfn ~/dotfiles/scripts/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/scripts/lazy-lock.json ~/.config/nvim/lazy-lock.json
ln -sfn ~/dotfiles/scripts/neovim.lua ~/.config/nvim/init.lua
ln -sfn ~/dotfiles/scripts/lua ~/.config/nvim/lua
ln -sfn ~/dotfiles/scripts/.tmux.conf ~/.tmux.conf

rm -rf "$HOME/.zinit"
rm -rf "$HOME/.oh-my-zsh"

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

brew bundle install e --file=~/dotfiles/scripts/Brewfile

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 
# asdf install nodejs 14.18.1
# asdf global nodejs 14.18.1

echo "Finished! Reload your terminal to use the latest setup."
