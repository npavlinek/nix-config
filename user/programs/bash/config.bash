check_program() {
  eval "$1 &> /dev/null"
  [[ $? -ne 127 ]] && echo 1 || echo 0
}

git_available=$(check_program git)

prompt() {
  local last_exit=$?
  if [[ $git_available -eq 1 ]]; then
    local git_branch=$(git branch --show-current 2> /dev/null)
  fi

  local blue='\[\e[1;34m\]'
  local green='\[\e[0;32m\]'
  local magenta='\[\e[1;35m\]'
  local red='\[\e[1;31m\]'
  local reset='\[\e[0m\]'

  PS1=''
  [[ $last_exit -ne 0 ]] && PS1+="$red[$last_exit]$reset "
  [[ -v IN_NIX_SHELL ]] && PS1+="$magenta[nix-shell]$reset "
  [[ -n "$git_branch" ]] && PS1+="$blue($git_branch)$reset "
  PS1+="$green\w$reset$ "
}

PROMPT_COMMAND=prompt
