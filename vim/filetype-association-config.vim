"=== File associations ===
"Associate file ending .X with Y
au BufNewFile,BufRead *.hbs setlocal ft=html
au BufNewFile,BufRead *.kata setlocal ft=groovy
au BufNewFile,BufRead *.ts setlocal ft=javascript
au BufNewFile,BufRead *.vim setlocal ft=vim
au BufNewFile,BufRead *.style setlocal ft=groovy

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
