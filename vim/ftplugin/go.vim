"=== Folding ===
set foldmethod=syntax "Fold based on syntax.

"Play nice with gofmt
set tabstop=4 "columns per tab character
set softtabstop=4 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=4 "columns per 'indent', used for <, >, and =

"Make tabs just show up as spaces without any further clutter
set listchars=tab:\ \ ,trail:·,extends:>,precedes:<
set list

nnoremap <localleader>a :GoAlternate<CR>
nnoremap <localleader>i :GoImports<CR>

inoremap ,, <space>:=<space>
inoremap nnn if err != nil {}<left><cr><cr><up><tab>

if filereadable("go.local.vim")
  source "go.local.vim"
endif
