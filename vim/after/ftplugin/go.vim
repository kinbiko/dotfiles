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

let g:go_metalinter_command='golangci-lint run --print-issued-lines=false'

"Print info of the type under the cursor
let g:go_def_mode = 'gopls'
let g:go_def_mapping_enabled = 0

" reuse buffer if open in a split on godef
let g:go_def_reuse_buffer = 0

nnoremap <leader>[ :GoDefPop<CR>
nnoremap <leader>] :GoDef<CR>
nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>c :GoCoverageToggle!<CR>
nnoremap <leader>d :GoDoc<CR>
nnoremap <leader>s :GoFillStruct<CR>
nnoremap <leader>i :GoImports<CR>
nnoremap <leader>l :GoMetaLinter<CR>
nnoremap <leader>t :GoTest!<CR>
nnoremap <leader>T :GoTestFunc!<CR>

inoremap <localleader>= <space>:=<space>
inoremap nnn <esc>:GoIfErr<CR>
inoremap testt func Test(t *testing.T){}<esc>15hi
inoremap stt t.Run(, func(t *testing.T){})<ESC>22hi

inoremap ccc context.Context
inoremap cbb context.Background()
inoremap iii interface{}
inoremap sss '%s'
inoremap ddd %d
inoremap vvv '%+v'

set foldmethod=syntax
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment', 'comment']

"Need to have non-red comments for Go to make coverage show up in a nice manner
highlight comment ctermfg=yellow
let g:go_list_type = "quickfix"

" The default of 10 seconds is too long
let g:go_test_timeout= '4s'

" Make No write since last change stfu
set autowrite

" Use quickfix windows for all tool-windows
let g:go_list_type = "quickfix"
" Give the metalinter a bit extra time to run
let g:go_metalinter_deadline = "5s"

" Stolen from fatih's dotfiles
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_info_mode = 'gopls'
let g:go_rename_command='gopls'
let g:go_gopls_complete_unimported = 1
let g:go_implements_mode='gopls'
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1
