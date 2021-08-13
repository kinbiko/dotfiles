require('plugins')
require('general')
require('mappings')

require('nerdtree')

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])
