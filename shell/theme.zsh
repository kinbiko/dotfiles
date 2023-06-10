# ls colors
autoload -U colors && colors

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

function colorize() {
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

local current_dir="$(colorize "%3~" "cyan")"
local return_status_symbols="%(?..%? 💀)"
local return_status_indicator=$(colorize "${return_status_symbols}" "red")
local lambda_prompt="$(colorize "λ" "white")"

# Main prompt
PROMPT='$(git_info) ${current_dir} ${return_status_indicator}
${lambda_prompt} '

# This shows up when a command runs longer than one line
PROMPT2=$(colorize "︙" "black")

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''
