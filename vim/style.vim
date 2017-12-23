"{{{ AIRLINE
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"{{{ Backup unicode symbols
" These are used as backup when there's no appropriate font installed
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
"}}}

"{{{ Super cool airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"}}}
let g:airline#extensions#tabline#enabled = 1
"Make airline appear on startup
set laststatus=2
"}}}

"{{{ COLORSCHEME
let g:nord_italic_comments = 0
colorscheme nord
"}}}

"{{{ SYNTASTIC

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '!'
let g:syntastic_style_error_symbol = '!'
let g:syntastic_warning_symbol = '?'
let g:syntastic_style_warning_symbol = '?'

let g:syntastic_error_symbol = '無'
let g:syntastic_warning_symbol = '悪'

let g:syntastic_style_error_symbol = '✠'
let g:syntastic_style_warning_symbol = '≈'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

"}}}

"Make comments red. This must be below other style configs to have an effect
highlight Comment cterm=italic
"Highlight lines longer than 120
match ErrorMsg '\%>120v.\+'
"Highlight trailing whitespace
match ErrorMsg '\s\+$'

let g:rehash256=1

"TODO: Make this work again :(
"Died after moving to nord
highlight comment ctermfg=DarkRed
