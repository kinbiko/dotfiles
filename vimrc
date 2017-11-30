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
source ~/.vim/prettier.vim

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

for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor
