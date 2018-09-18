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
" Highlight some more stuff
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

"In case the linter runs for too long
let g:go_metalinter_deadline = "1s"

"Print info of the type under the cursor
let g:go_auto_type_info = 1

nnoremap <localleader>a :GoAlternate<CR>
nnoremap <localleader>i :GoImports<CR>

nnoremap tt :GoTest!<CR>
nnoremap tf :GoTestFunc!<CR>
nnoremap cc :GoCoverageToggle<CR>
nnoremap ] :GoDef<CR>
nnoremap [ :GoDefPop<CR>

inoremap ,, <space>:=<space>
inoremap nnn if err != nil {}<left><cr><cr><up><tab>
inoremap testt func Test(t *testing.T){}<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

inoremap sss '%s'
inoremap ddd %d
inoremap vvv '%+v'

"Need to have non-red comments for Go to make coverage show up in a nice
"manner
highlight comment ctermfg=darkgray
