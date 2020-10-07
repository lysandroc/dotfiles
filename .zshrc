export ZSH="~/.oh-my-zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH 

source $ZSH/oh-my-zsh.sh

plugins=(git dotenv zsh-autosuggestions zsh-iterm-touchbar tmux)

[ -f ~/.dotfiles/plugins.zsh ] && source ~/.dotfiles/plugins.zsh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.dotfiles/alias_expansion.zsh ] && source ~/.dotfiles/alias_expansion.zsh
[ -f ~/.dotfiles/alias_commands.zsh ] && source ~/.dotfiles/alias_commands.zsh

[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-messages -g "!{.git}"'

export GOPATH=$HOME/golang
GOV=$(asdf current golang | awk '{print $1}')
export GOROOT=/Users/lysandroc/.asdf/installs/golang/$GOV/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

eval "$(starship init zsh)"
