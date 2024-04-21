function git_branch {
    local branch=$(git branch 2> /dev/null | sed -n '/^\*/s/^\* //p')
    [[ -n $branch ]] && echo " ($branch)" 
}

setopt PROMPT_SUBST
autoload -U colors && colors
autoload -Uz add-zsh-hook

function custom_pwd {
  local dir=${PWD/#$HOME/'~'}
  local parts=("${(@s:/:)dir}")
  local num_parts=${#parts[@]}
  if (( num_parts > 1 )); then
    echo "${parts[-2]}/${parts[-1]}"
  else
    echo "$dir"
  fi
}

function update_prompt {
    PROMPT="%{$fg[yellow]%}%n %{$fg[cyan]%}@ %{$fg[yellow]%}%m %{$fg[cyan]%}:: %{$fg[yellow]%}$(custom_pwd)%{$fg[cyan]%}$(git_branch) %{$fg[yellow]%}%% "
}

add-zsh-hook precmd update_prompt

