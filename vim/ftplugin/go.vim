"=== Folding ===
set foldmethod=syntax "Fold based on syntax.

"Play nice with gofmt
set tabstop=4 "columns per tab character
set softtabstop=4 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=4 "columns per 'indent', used for <, >, and =

"Make tabs just show up as spaces without any further clutter
set listchars=tab:\ \ ,trail:·,extends:>,precedes:<
set list

nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>t :GoTest<CR>
nnoremap <leader>g :GoBuild<CR>
nnoremap <leader>c :GoCoverageToggle<CR>
inoremap :: <space>:=<space>

" Run the current file with testunit
map <Leader>r :call VimuxRunCommand("clear; go run " . bufname("%"))<CR>
