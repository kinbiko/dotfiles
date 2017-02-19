"Load the plugins before trying to configure any settings
source ~/.vim/install-plugins.vim
source ~/.vim/airline-config.vim
source ~/.vim/nerdtree-config.vim
source ~/.vim/syntastic-config.vim
source ~/.vim/plugin-config.vim
source ~/.vim/general-config.vim
source ~/.vim/filetype-association-config.vim
source ~/.vim/typos-config.vim
source ~/.vim/mapping-config.vim

"Make comments red. This must be below other style configs to have an effect
hi comment ctermfg=DarkRed

"=== WANT ===
"1: Can I change the behaviour of { and } in normal mode to be [ and ] instead?
"2: Change variable name to UPPER_SNAKE_CASE with U in normal mode
"3: Command for running ctags in the current directory
"4: Make trailing whitespace characters obvious
