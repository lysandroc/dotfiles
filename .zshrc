export ZSH="/Users/lysandroc/.oh-my-zsh"

export PATH=$HOME/bin:/usr/local/bin:$PATH 

source $ZSH/oh-my-zsh.sh

plugins=(git dotenv zsh-autosuggestions zsh-iterm-touchbar tmux)

[ -f ~/.dotfiles/plugins.zsh ] && source ~/.dotfiles/plugins.zsh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.dotfiles/alias_expansion.zsh ] && source ~/.dotfiles/alias_expansion.zsh

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

########## Aliases ##########

# alias: Expand with whitespace at the end
# balias: Expand without whitespace at the end
# ialias: Don't expand
alias vs="code-insiders ."
alias vim="nvim"
alias vi="nvim"

alias gpr="gh pr"
alias gprc="gh pr create"
alias gprl="gh pr list"
alias gprv="gh pr view"

alias tm="tmux"
alias tma="tmux attach-session"
alias tmd="tmux detach"
alias tmn="tmux new-session"
alias tmls="tmux ls"
alias tmks="tmux kill-session"
alias tmksv="tmux kill-server"

alias g="git"
alias gl="git log --graph --decorate --all"
alias gfa="git fetch --all"

ialias fzf="fzf --color=16 --preview 'bat --style=numbers --color=always {}'"

ialias ls="exa"
ialias ll="exa -l"
ialias l="exa -l"
ialias cat="bat"

open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}

cd_with_fzf() {
    local exclude="go"
    local dir="$(fd -t d --exclude ${exclude} | fzf --preview="tree -L 1 {}")"
    cd "$dir"
}

bindkey -s '^o' 'cd_with_fzf \n'
