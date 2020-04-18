"Make Emmet available through h + h
imap hh <C-y>

"Make cl. insert a console log statement
inoremap <localleader>l console.log();<left><left>

" Make >> insert a fat arrow
inoremap >> <space>=><space>

"Tend to write React, where it's annoying to fold JSX excessively
set foldlevel=10
set foldmethod=syntax "Fold based on indentation

set tabstop=2 "number of VISUAL SPACES per tab
set softtabstop=2 "Number of spaces per tab when editing
set shiftwidth=2 "Indenting is 4 spaces
set expandtab "converts tabs to spaces

"{{{ prettier/vim-prettier
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80
" number of spaces per indentation level
let g:prettier#config#tab_width = 2
" print semicolons
let g:prettier#config#semi = 'true'
" single quotes over double quotes
let g:prettier#config#single_quote = 'false'
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
augroup prettier_group
  autocmd!
  autocmd BufWritePre *.js,*.jsx PrettierAsync
augroup END
"}}}

"{{{ pangloss/vim-javascript
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_arrow_function       = "⇒"

" Always use concealment
set conceallevel=1
"}}}
