"Make Emmet available through h + h
imap hh <C-y>

"Make cl. insert a console log statement
inoremap cl. console.log();<left><left>

"Tend to write React, where it's annoying to fold JSX excessively
set foldlevel=10
set foldmethod=syntax "Fold based on indentation

"{{{ pangloss/vim-javascript
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_arrow_function       = "⇒"

" Always conceal
set conceallevel=1
" See repo README for info on how to toggle if necessary
"}}}
