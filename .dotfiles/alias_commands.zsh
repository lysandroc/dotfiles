########## Aliases ##########
## alias: Expand with whitespace at the end
## balias: Expand without whitespace at the end
## ialias: Don't expand
alias template="source ~/.oh-my-zsh/templates/zshrc.zsh-template"

alias vs="code-insiders ."
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

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

ialias ls="exa --all"
ialias ll="exa -l --all"
ialias l="exa -l --all"
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
