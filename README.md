Prerequisites 
- tmux, neovim nightly
- zsh, zinit, ohmyzsh, zinit, starship
- asdf
- fzf, ripgrep, autojump, exa, fd, delta, bat

Clone this repo in the user root folder
```
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.dotfiles/neovim.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/.dotfiles/lua ~/.config/nvim/lua
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
```

Shortcuts
```
ctrl + space -> autocomplete and runs the written command
alt + space -> runs the last executed command
ctrl + e -> just autocomplete the command
ctrl + r -> search a command in the history
ctrl + o -> search a folder in the current directory
ctrl + P -> search and open a file in the current directory (disabled)

tmux prefix + O -> opens the dotfile project in a new tmux window
```

### - [alias command available](/.dotfiles/alias_commands.zsh)

### - [vim notes](https://www.notion.so/Vim-d575e6a95dff4fb993b39c9f122820b3)
