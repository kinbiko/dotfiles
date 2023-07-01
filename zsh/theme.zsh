setopt PROMPT_SUBST # Make substitutions in prompt strings, allowing for coloring.

# ls colors
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

function colorize() {
  echo "%{$fg[$2]%}$1%{$reset_color%}"
}
function colorize_bold() {
  echo "%{$fg_bold[$2]%}$1%{$reset_color%}"
}

function git_info() {
  if ! GIT_OPTIONAL_LOCKS=0 command git rev-parse --git-dir &> /dev/null; then
    return 0
  fi

  local is_dirty=$(GIT_OPTIONAL_LOCKS=0 command git status --porcelain 2> /dev/null | tail -n 1)
  if [[ -n $is_dirty ]]; then
    local color="yellow"
  else
    local color="green"
  fi

  local branch=$(GIT_OPTIONAL_LOCKS=0 command git symbolic-ref --short HEAD 2> /dev/null || echo "<<not on a branch>>")
  echo "$(colorize "⎇ ${branch}" $color)"
}

local current_dir="$(colorize_bold "%3~" "cyan")"
local return_status_symbols="%(?..%? 💀)"
local return_status_indicator=$(colorize "${return_status_symbols}" "red")
local lambda_prompt="$(colorize_bold "»" "red")"
if [[ -n "$TMUX" ]]; then
  lambda_prompt="$(colorize_bold "λ" "white")"
fi

# Main prompt
PS1='${current_dir} $(git_info) ${return_status_indicator}
${lambda_prompt} '

#local current_time='$(date "+%Y-%m-%dT%H:%M:%S")'
#RPS1="$(colorize "${current_time}" "white")"

# This shows up when a command runs longer than one line
PS2=$(colorize_bold "︙" "black")

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''
