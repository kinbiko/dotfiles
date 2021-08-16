local map = require('kinbiko.util').map

vim.cmd([[
augroup prettier_group
  autocmd!
  autocmd BufWritePre *.jsx,*.js,*.tsx,*.ts,*.md PrettierAsync
augroup END
]])

-- Enable Emmet
map('i', 'hh', '<C-y>', { silent = true })
