augroup prettier_group
  autocmd!
  autocmd BufWritePre *.jsx,*.js PrettierAsync
augroup END

"Make Emmet available through h + h
imap hh <C-y>
