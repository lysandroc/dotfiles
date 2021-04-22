Prerequisites 
- zsh, ohmyzsh, starship
- asdf
- neovim
- fzf, ripgrep, autojump, exa, fd, delta, bat

Clone this repo in the user root folder
```
ln -s ~/dotfiles/.zshrc ~/.zshrc
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
```

More shortcuts are available inside of alias_commands.zsh
