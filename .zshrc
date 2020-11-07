export ZSH="~/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

plugins=(
  git
  zsh-autosuggestions
  fzf
  ripgrep
  dotenv
  tmux
  zsh-syntax-highlighting)
)

[ -f ~/.dotfiles/plugins.zsh ] && source ~/.dotfiles/plugins.zsh

# it needs to turn avaiable for mac and linux
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.dotfiles/alias_expansion.zsh ] && source ~/.dotfiles/alias_expansion.zsh
[ -f ~/.dotfiles/alias_commands.zsh ] && source ~/.dotfiles/alias_commands.zsh
[ -f ~/.dotfiles/environment_variables.zsh ] && source ~/.dotfiles/environment_variables.zsh

[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

eval "$(starship init zsh)"
