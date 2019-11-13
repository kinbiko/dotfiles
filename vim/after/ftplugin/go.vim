set nofoldenable "Disable folding

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

let g:go_metalinter_command='golangci-lint'

"Print info of the type under the cursor
let g:go_def_mode = 'gopls'
let g:go_def_mapping_enabled = 0

" reuse buffer if open in a split on godef
let g:go_def_reuse_buffer = 0

nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>i :GoImports<CR>

nnoremap <leader>t :GoTest!<CR>
nnoremap <leader>T :GoTestFunc!<CR>
nnoremap <leader>] :GoDef<CR>
nnoremap <leader>[ :GoDefPop<CR>

inoremap <localleader>= <space>:=<space>
inoremap nnn <esc>:GoIfErr<CR>
inoremap testt func Test(t *testing.T){}<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
inoremap stt t.Run(, func(t *testing.T){})<ESC>22hi

inoremap ccc context.Context
inoremap cbb context.Background()
inoremap iii interface{}
inoremap sss '%s'
inoremap ddd %d
inoremap vvv '%+v'

"Need to have non-red comments for Go to make coverage show up in a nice manner
highlight comment ctermfg=darkgray
let g:go_list_type = "quickfix"

" The default of 10 seconds is too long
let g:go_test_timeout= '4s'

" If only testify could be a bit less verbose
let g:go_list_height = 15

" Make No write since last change stfu
set autowrite
