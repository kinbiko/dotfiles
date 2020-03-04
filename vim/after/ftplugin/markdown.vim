au Filetype markdown set spell wrap

augroup prettier_group
  autocmd!
  autocmd BufWritePre *.md PrettierAsync
augroup END

inoremap qqq - [ ] Q:<space>
inoremap aaa <space>   - A:<space>
