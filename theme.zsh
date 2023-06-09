# ls colors
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

setopt prompt_subst

typeset +H _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%}"
typeset +H _return_status=" %{$fg_bold[red]%}%(?..☠︎☠︎☠︎)%{$reset_color%}"

function git_prompt_info() {
  if ! GIT_OPTIONAL_LOCKS=0 command git rev-parse --git-dir &> /dev/null; then
    return 0
  fi

  if [[ -n $(GIT_OPTIONAL_LOCKS=0 command git status --porcelain 2> /dev/null | tail -n 1) ]]; then
    echo "%{$fg[yellow]%}⎇ ${$(GIT_OPTIONAL_LOCKS=0 command git symbolic-ref --short HEAD 2> /dev/null || echo "<<not on a branch>>")}%{$reset_color%} "
  else
    echo "%{$fg[green]%}⎇ ${$(GIT_OPTIONAL_LOCKS=0 command git symbolic-ref --short HEAD 2> /dev/null || echo "<<not on a branch>>")}%{$reset_color%} "
  fi
}

# Main prompt
PROMPT='$(git_prompt_info)${_current_dir}${_return_status}
${fg[white]}λ${fg[yellow]}%{$reset_color%} '

# This shows up when a command runs longer than one line
PROMPT2='${fg[white]}︙%{$reset_color%}'
