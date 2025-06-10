eval "$(/opt/homebrew/bin/brew shellenv)"

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

export ASDF_DATA_DIR="/Users/alex/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH:$HOME/bin:$HOME/.local/bin"

# pnpm
export PNPM_HOME="/Users/alex/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
