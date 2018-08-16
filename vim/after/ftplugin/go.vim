"{{{ Folding
set foldmethod=syntax "Fold based on syntax.
"}}}

"{{{ Play nice with gofmt
set tabstop=4 "columns per tab character
set softtabstop=4 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=4 "columns per 'indent', used for <, >, and =

"Make tabs just show up as spaces without any further clutter
set listchars=tab:\ \ ,trail:·,extends:>,precedes:<
set list
"}}}

" Show the name of the test that's being run
let g:go_test_show_name = 1
" Don't automatically jump to the first error in the quickfix window
let g:go_jump_to_error = 0
" Use goimports over gofmt
"let g:go_fmt_command = "goimports"

nnoremap <localleader>a :GoAlternate<CR>
nnoremap tt :GoTest!<CR>
nnoremap <localleader>i :GoImports<CR>

nnoremap ] :GoDef<CR>
nnoremap [ :GoDefPop<CR>

inoremap ,, <space>:=<space>
inoremap nnn if err != nil {}<left><cr><cr><up><tab>
inoremap testt func Test(t *testing.T){}<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
