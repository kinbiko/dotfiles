au Filetype markdown set spell wrap

augroup prettier_group
  autocmd!
  autocmd BufWritePre *.md PrettierAsync
augroup END

" I often use questions-and-answer-style notes when doing discovery work.
inoremap qqq - [ ] Q:<space>
inoremap aaa <space>   - A:<space>

"Make Emmet available through h + h
imap hh <C-y>
