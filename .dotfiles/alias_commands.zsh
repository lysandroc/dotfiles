########## Aliases ##########
## alias: Expand with whitespace at the end
## balias: Expand without whitespace at the end
## ialias: Don't expand
#############################

alias template="source ~/.oh-my-zsh/templates/zshrc.zsh-template"

ialias edit="nvim ~/.zshrc"
ialias src="source ~/.zshrc"

alias daily="npm run start-daily"
alias wd="source ~/dotfiles/.dotfiles/tmux -d"
alias wt="source ~/dotfiles/.dotfiles/tmux -t"

alias vs="code-insiders ."

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

alias tm="tmux"
alias tma="tmux attach-session"
alias tmd="tmux detach"
alias tmn="tmux new-session"
alias tmls="tmux ls"
alias tmks="tmux kill-session"
alias tmksv="tmux kill-server"

alias ghp="gh pr create -a lysandro-carioca"

alias g="git"
alias gl="git log --graph --decorate --all"
alias gds="git diff --staged"
alias gd="git diff"
alias gf="git fetch --all --no-tags"
alias grm="git reset --hard origin/master"
alias gri="git rebase --i origin/master"
alias gc="git checkout"
alias gs="git status"
alias gpf="git push --set-upstream origin \$(git symbolic-ref --short HEAD)"

ialias fzf="fzf --color=16 --preview 'bat --style=numbers --color=always {}'"

ialias ls="exa --all"
ialias ll="exa -l --all"
ialias l="exa -l --all"
ialias cat="bat"

# open_with_fzf() {
#   fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
# }

cd_with_fzf() {
  local exclude="go"
  local dir="$(fd -t d -H --exclude ${exclude} | fzf --preview="tree -L 1 {}")"
  cd "$dir"
}

bindkey -s '^o' 'cd_with_fzf \n'
# bindkey -s '^P' 'open_with_fzf \n'
