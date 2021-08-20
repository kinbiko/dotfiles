require('kinbiko.mappings').mapEmmet()

vim.cmd([[
augroup prettier_group
  autocmd!
  autocmd BufWritePre *.jsx,*.js,*.tsx,*.ts,*.md PrettierAsync
augroup END
]])
