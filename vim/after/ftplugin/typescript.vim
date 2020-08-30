set filetype=typescript.tsx

augroup prettier_group
  autocmd!
  autocmd BufWritePre *.tsx,*.ts PrettierAsync
augroup END

"Make Emmet available through h + h
imap hh <C-y>
