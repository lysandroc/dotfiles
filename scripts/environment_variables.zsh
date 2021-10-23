export GOPATH=$HOME/go
#export GOROOT=~/.asdf/installs/golang/$(asdf current golang | awk '{print $1}')/go/
#export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$GOROOT/bin

# turn user binaries available through command like
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH 

export ZSH_DISABLE_COMPFIX="true"
export SOLARIZED_THEME="dark"
export FORCE_COLOR=true
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-messages -g "!{.git}"'

# exilir 
# export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
# export PATH="$HOME/.serverless/bin:$PATH"
#
# export PATH="/Users/lysandroc/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
#
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"


