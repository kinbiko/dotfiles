require('kinbiko.mappings').mapEmmet()

vim.g.user_emmet_install_global = false

vim.cmd([[
augroup web_group
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync
  autocmd FileType html,typescriptreact,typescript,javascript,svelte EmmetInstall
augroup END
]])
