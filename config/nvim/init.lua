require('plugins')
require('general')
require('nerdtree')
require('mappings')

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])
