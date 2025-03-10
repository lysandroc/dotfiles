########## Aliases ##########
## alias: Expand with whitespace at the end
## balias: Expand without whitespace at the end
## ialias: Don't expand
#############################
alias template="source ~/.oh-my-zsh/templates/zshrc.zsh-template"

ialias edit="nvim ~/.local_settings.zsh"
ialias src="source ~/.zshrc"

# alias wd="source ~/dotfiles/scripts/tmux -d"
# alias wt="source ~/dotfiles/scripts/tmux -t"
# alias wr="source ~/dotfiles/scripts/tmux -relationshiptime"
# alias wes="source ~/dotfiles/scripts/tmux -engine-segmentation"
# alias segmentation="source ~/dotfiles/scripts/tmux -segmentation"
# alias malotes="source ~/dotfiles/scripts/tmux -malotes"
alias hub="source ~/dotfiles/scripts/tmux -hub"
alias lv="source ~/dotfiles/scripts/tmux -listview"
alias og="source ~/dotfiles/scripts/tmux -og"

alias vs="code-insiders ."

alias vim="nvim"
alias v="nvim"

alias tm="tmux"
alias tma="tmux attach-session"
alias tmd="tmux detach"
alias tmn="tmux new-session"
alias tmls="tmux ls"
alias tmks="tmux kill-session"
alias tmksv="tmux kill-server"

alias g="git"
alias gl="git log --graph --decorate --all"
alias gds="git diff --staged"
alias gd="git diff"
alias gf="git fetch --all --no-tags"
alias grm="git reset --hard origin/master"
alias gri="git rebase --i origin/master"
alias gc="git checkout"
alias gs="git status"
alias gpu="git pull"
alias gp="git push"
alias gpf="git push --set-upstream origin \$(git symbolic-ref --short HEAD)"
# alias gai="git-aicommit --openAiKey=$OPENAI_API_KEY --completionPromptParams.temperature=0.3 --no-autocommit"

alias ghpr="gh pr create -a lysandroc"
alias ghvw="gh pr view --web"
alias ct="bat ~/dotfiles/scripts/commit-types.txt"
alias cy="yarn run cypress:open"

ialias fzf="fzf --color=16 --preview 'bat --style=numbers --color=always {}'"

ialias ls="eza --all"
ialias ll="eza -l --all"
ialias l="eza -l --all"
ialias cat="bat"

alias tree="eza -a --tree --level=2 --long --ignore-glob=\"*.git*\""

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
gwip() {
  git add -A && gcps
}

# Rebase and squash all commits on top of master (by default) or can supply another branch as first argument
gsq() {
  BRANCH=${1:-master}

  GIT_SEQUENCE_EDITOR='sed -i '' -e "2,\$s/pick/f/"' git rebase -i $BRANCH
}

# Rebase and squash current commit on top of previous commit
gsquash() {
  # We need to pass in the ref of commit that's before the previous commit due to how rebase works
  gsq $(git rev-parse @~2)
}

# Checkout from list of branches sorted by most recent commit using fzf
gcheckout() {
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
# bindkey -s '^I' 'gwip -m "working in progress" \n'
bindkey -s '^P' 'source ~/dotfiles/scripts/tmux -openProject \n'
bindkey -s '^G' 'gcheckout \n'
