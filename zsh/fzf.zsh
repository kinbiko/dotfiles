export FZF_DEFAULT_COMMAND='rg --files-with-matches --hidden .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
