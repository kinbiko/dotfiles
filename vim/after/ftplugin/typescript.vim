autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

set filetype=typescriptreact

augroup prettier_group
  autocmd!
  autocmd BufWritePre *.tsx,*.ts PrettierAsync
augroup END

"Make Emmet available through h + h
imap hh <C-y>
