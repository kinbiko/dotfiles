SAVEHIST=10000          # Number of commands to keep in history file
HISTSIZE=10000          # Number of lines the shell keeps in one session
HISTFILE=~/.zsh_history # History file location

# Docs: https://zsh.sourceforge.io/Guide/zshguide02.html section: 2.5.5: History options
setopt APPEND_HISTORY         # Append history instead of overwriting
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_VERIFY            # Expand history references (e.g. !!) instead of running right away
setopt SHARE_HISTORY          # share command history data across sessions
setopt EXTENDED_HISTORY       # Write datetime and duration to history. List with 'history -Di'
setopt HIST_ALLOW_CLOBBER     # Let the history auto insert >| when using clobbering redirection
setopt HIST_IGNORE_SPACE      # Don't append commands that start with space to the history
setopt HIST_NO_STORE          # Don't store 'history' or 'fc' commands in history
