"Load the plugins before trying to configure any settings
source ~/.vim/install-plugins.vim
source ~/.vim/airline-config.vim
source ~/.vim/syntastic-config.vim
source ~/.vim/plugin-config.vim
source ~/.vim/nerdtree-config.vim
source ~/.vim/general-config.vim
source ~/.vim/typos-config.vim
source ~/.vim/mapping-config.vim
source ~/.vim/abbreviations.vim
"Make comments red. This must be below other style configs to have an effect
hi comment ctermfg=DarkRed

"Highlight lines longer than 120
match ErrorMsg '\%>120v.\+'
"Highlight trailing whitespace
match ErrorMsg '\s\+$'
" Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '✠'
let g:syntastic_style_warning_symbol = '≈'

" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" print semicolons
let g:prettier#config#semi = 'true'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'

" none|es5|all
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|postcss|json|graphql
let g:prettier#config#parser = 'flow'

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

nnoremap <c-N> :GitGutterNextHunk<cr>
nnoremap <c-U> :GitGutterUndoHunk<cr>
nnoremap <c-P> :GitGutterPrevHunk<cr>
