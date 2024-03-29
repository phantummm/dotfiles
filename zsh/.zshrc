# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nanotech"
ZSH_DISABLE_COMPFIX="true"

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

unsetopt AUTO_CD

export PATH="$HOME/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# yarn
# export PATH="$PATH:`yarn global bin`"

# rbenv shims
export PATH="$HOME/.rbenv/shims:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if which pyenv > /dev/null
	then
      eval "$(pyenv init --path)"
      eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# docker helper functions
if [ -f "~/.dockerfunc" ]; then
	. $HOME/.dockerfunc
fi

if [[ -d /Users/ahunley ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# aliases
alias cdr='cd ~/r'
alias cdd='cd ~/r/dotfiles'

alias gbrm="git branch | grep -v "master" | xargs git branch -D"
alias gbclean="git branch -vv | awk '/: gone]/{print $1}' | xargs --no-run-if-empty git branch -D"

alias dcr="docker-compose run --rm"

# welcome-specific
alias list_routes="docker-compose exec backend django-admin show_urls"
alias run_test="docker-compose exec backend django-admin test --no-input"

commit_dotfiles() {
    if [[ -d ~/.dotfiles ]]; then
        pushd ~/.dotfiles && git add -A && git commit -m $1 && git push && popd
    fi
}

dbash() {
    if hash docker 2>/dev/null; then
        docker exec -it $1 bash
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.cargo/env ] && source ~/.cargo/env

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Golang
export PATH="$PATH:/usr/local/go/bin"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
