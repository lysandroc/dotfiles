plugins=(
  git
  fzf
  ripgrep
  dotenv
  tmux
)

[ -f ~/dotfiles/scripts/plugins.zsh ] && source ~/dotfiles/scripts/plugins.zsh

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && source /opt/homebrew/etc/profile.d/autojump.sh
[ -f ~/.autojump/etc/profile.d/autojump.sh ] && source ~/.autojump/etc/profile.d/autojump.sh

[ -f ~/dotfiles/scripts/alias_expansion.zsh ] && source ~/dotfiles/scripts/alias_expansion.zsh
[ -f ~/dotfiles/scripts/alias_commands.zsh ] && source ~/dotfiles/scripts/alias_commands.zsh
[ -f ~/dotfiles/scripts/environment_variables.zsh ] && source ~/dotfiles/scripts/environment_variables.zsh

[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

[ -f $(brew --prefix asdf)/libexec/asdf.sh ] && source $(brew --prefix asdf)/libexec/asdf.sh
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

[ -f ~/.local_settings.zsh ] && source ~/.local_settings.zsh

eval "$(starship init zsh)"

autoload -Uz compinit && compinit
