# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nanotech"
ZSH_DISABLE_COMPFIX="true"

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

unsetopt AUTO_CD

if [ -d /Users/alex ]; then
  export PATH="/Users/alex/bin:/Users/alex/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin"
fi

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# yarn
# export PATH="$PATH:`yarn global bin`"

# rbenv shims
export PATH="$HOME/.rbenv/bin:$PATH"''
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
export PATH="/Users/alex/.pyenv/bin:$PATH"
if which pyenv > /dev/null
	then
		eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# docker helper functions
if [ -f "~/.dockerfunc" ]; then
	. $HOME/.dockerfunc
fi

# syntax-highlighting in less
# requires highlight (`brew install highlight`)
# export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style relaxedgreen"
# export LESS=" -R"
# alias less='less -m -N -g -i -J --line-numbers --underline-special'
# alias more='less'

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
    if [[ -d ~/r/dotfiles ]]; then
        pushd ~/r/dotfiles && git add -A && git commit -m $1 && git push && popd
    fi
}

dbash() {
    if hash docker 2>/dev/null; then
        docker exec -it $1 bash
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.cargo/env ] && source ~/.cargo/env
