export ZSH="/home/lysandroc/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(
  git
  fzf
  ripgrep
  dotenv
  tmux
)

[ -f ~/dotfiles/.dotfiles/plugins.zsh ] && source ~/dotfiles/.dotfiles/plugins.zsh

[ -f ~/autojump/bin/autojump.sh ] && source ~/autojump/bin/autojump.sh

[ -f ~/dotfiles/.dotfiles/alias_expansion.zsh ] && source ~/dotfiles/.dotfiles/alias_expansion.zsh
[ -f ~/dotfiles/.dotfiles/alias_commands.zsh ] && source ~/dotfiles/.dotfiles/alias_commands.zsh
[ -f ~/dotfiles/.dotfiles/environment_variables.zsh ] && source ~/dotfiles/.dotfiles/environment_variables.zsh

[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

[ -f ~/.local_settings.zsh ] && source ~/.local_settings.zsh

eval "$(starship init zsh)"
