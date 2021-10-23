########## Aliases ##########
## alias: Expand with whitespace at the end
## balias: Expand without whitespace at the end
## ialias: Don't expand
#############################
alias template="source ~/.oh-my-zsh/templates/zshrc.zsh-template"

ialias edit="nvim ~/.zshrc"
ialias src="source ~/.zshrc"

# alias wd="source ~/dotfiles/scripts/tmux -d"
# alias wt="source ~/dotfiles/scripts/tmux -t"
alias wr="source ~/dotfiles/scripts/tmux -relationshiptime"
alias wes="source ~/dotfiles/scripts/tmux -engine-segmentation"
alias ws="source ~/dotfiles/scripts/tmux -segmentation"
alias wm="source ~/dotfiles/scripts/tmux -malotes"

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
alias gp="git push"
alias gpf="git push --set-upstream origin \$(git symbolic-ref --short HEAD)"

alias ct="bat ~/dotfiles/scripts/commit-types.txt"

ialias fzf="fzf --color=16 --preview 'bat --style=numbers --color=always {}'"

ialias ls="exa --all"
ialias ll="exa -l --all"
ialias l="exa -l --all"
ialias cat="bat"

alias tree="exa -a --tree --level=2 --long --ignore-glob=\"*.git*\""

open_with_fzf() {
  nvim $(fzf)
}

cd_with_fzf() {
  local exclude="go"
  local dir="$(fd -t d -H --exclude ${exclude} | fzf --preview="tree -L 1 {}")"
  cd "$dir"
}

# Commits staged and pushes in one go (e.g. gcps -m "another test passes")
gcps() {
  git commit "$@" && git push
}

# Commits all changes and pushes in one go (e.g. gacps -m "another test passes")
gacps() {
  git add -A && gcps
}

# Rebase and squash all commits on top of master (by default) or can supply another branch as first argument
gsq() {
  BRANCH=${1:-master}

  GIT_SEQUENCE_EDITOR='sed -i '' -e "2,\$s/pick/f/"' git rebase -i $BRANCH
}

# Rebase and squash current commit on top of previous commit
gsqp() {
  # We need to pass in the ref of commit that's before the previous commit due to how rebase works
  gsq $(git rev-parse @~2)
}

gwip() {
  git add .
  git commit -m "wip"
}

# Checkout from list of branches sorted by most recent commit using fzf
gcof() {
  local BRANCHES BRANCH

  BRANCHES=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  BRANCH=$(echo "$BRANCHES" | fzf-tmux -d $(( 2 + $(wc -l <<< "$BRANCHES") )) +m) &&
  git checkout $(echo "$BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

watch() {
  while true; 
  do 
    eval $@;
    sleep 300; 
  done;
}

bindkey -s '^[ ' '!!^M' 

# bindkey -s '^o' 'cd_with_fzf \n'
# bindkey -s '^P' 'open_with_fzf \n'
# bindkey -s '^G' 'gcof \n'
# bindkey -s '^I' 'gacps -m "working in progress" \n'
# bindkey -s '^W' 'tmux neww -n "teste" watch_auth \n'
