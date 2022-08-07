require('kinbiko.mappings').mapEmmet()

vim.g.user_emmet_install_global = false

vim.cmd([[
augroup web_group
  autocmd!
  autocmd BufWritePre *.jsx,*.js,*.tsx,*.ts,*.md,*.html,*svelte PrettierAsync
  autocmd FileType html,typescriptreact,typescript,javascript,svelte EmmetInstall
augroup END
]])
