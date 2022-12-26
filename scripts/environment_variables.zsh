export HISTFILESIZE=10000

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH 
# export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"

export GOROOT=~/.asdf/installs/golang/$(asdf current golang | awk '{print $2}')/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export GOPATH=$(go env GOPATH)
export PATH="$PATH:$(go env GOPATH)/bin"
export CGO_ENABLED=1


export ZSH_DISABLE_COMPFIX="true"
export SOLARIZED_THEME="dark"
export FORCE_COLOR=true
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-messages -g "!{.git}"'

# export PATH="/Users/lysandroc/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# export OPENAI_API_KEY=""
export NVIM_MAGIC_LOGLEVEL='debug'
