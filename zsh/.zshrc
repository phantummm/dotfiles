eval "$(/opt/homebrew/bin/brew shellenv)"

source /opt/homebrew/opt/asdf/libexec/asdf.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.shell-includes/prompt.zsh
source ~/.shell-includes/aliases.zsh

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

PATH="$PATH:$HOME/bin"
