local map = require('util').map
-- Keys I rarely use in normal mode (OK to overwrite):
-- t E K L M X Y Z [ ] \ | <left> <right>

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

map('n', '0', '^', {noremap=true, silent=true}) -- Make 0 take me to the first non-blank character of the line.

-- More precise marks by default
map('n', "'", '`', {noremap=true, silent=true})
map('o', "'", '`', {noremap=true, silent=true})

-- Make arrow key navigation more useful
-- Note to the reader: I've programmed a second layer on my ergodox keyboard to
-- map hjkl to the arrow keys. So even when I do use the arrow keys my fingers
-- don't leave the home row.
map('', '<up>', '{', {noremap=true, silent=true})
map('', '<down>', '}', {noremap=true, silent=true})

-- Switch to the previous buffer.
map('n', '<localleader>.', ':b#<cr>', {noremap=true, silent=true})

-- Clear the current search highlight
map('n', '<localleader><leader>', ':nohlsearch<CR>', {noremap=true, silent=true})

-- Find using vimium-like search feature
map('n', '<leader>f', '<Plug>(easymotion-prefix)s', {})

-- Pop open a window for fuzzy-finding and opening a file in the repo.
map('n', '?', ':Files<cr>', {noremap=true, silent=true})

-- Undo the unstaged Git hunk
map('n', '<leader>u', ':GitGutterUndoHunk<cr>', {noremap=true, silent=true})

-- More intuitive to me than ctrl+n and ctrl+p
map('i', '<c-j>', '<c-n>', {noremap=true, silent=true})
map('i', '<c-k>', '<c-p>', {noremap=true, silent=true})

-- Highlight the current word, and prepare to cycle through with n.
map('', '#', '<Plug>(asterisk-z*)zz', {silent=true})
map('', '*', '<Plug>(asterisk-z#)zz', {silent=true})

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz', {noremap=true, silent=true})
map('n', 'N', 'Nzz', {noremap=true, silent=true})

-- Intuitive increment and decrement
map('n', '+', '<c-a>', {noremap=true, silent=true})
map('n', '-', '<c-x>', {noremap=true, silent=true})

-- Conveniently enter command mode
map('n', ';', ':', {noremap=true})

-- Copy to the system clipboard
map('v', 'Y', '"*y', {noremap=true, silent=true})

-- in/de-dent lines and remember the selection
map('v', '<', '<gv', {noremap=true, silent=true})
map('v', '>', '>gv', {noremap=true, silent=true})
map('v', 'H', '<gv', {noremap=true, silent=true})
map('v', 'L', '>gv', {noremap=true, silent=true})
map('n', '>', '>>', {noremap=true, silent=true})
map('n', '<', '<<', {noremap=true, silent=true})

-- Execute the last played macro
map('n', 'Q', '@@', {noremap=true, silent=true})

-- Surround the current word with the following character
map('n', 'S', 'ysiw', {silent=true})

-- Move up and down wrapped lines intuitively, not literally
map('n', 'j', 'gj', {noremap=true, silent=true})
map('n', 'k', 'gk', {noremap=true, silent=true})

-- Easy access to normal mode from insert mode
map('i', 'jk', '<esc>', {noremap=true, silent=true})

-- Quick-save the current buffer
map('n', 's', ':w<cr>', {noremap=true})

-- More easily switch window in the given direction
map('n', '<C-J>', '<C-W><C-J>', {noremap=true, silent=true})
map('n', '<C-K>', '<C-W><C-K>', {noremap=true, silent=true})
map('n', '<C-L>', '<C-W><C-L>', {noremap=true, silent=true})
map('n', '<C-H>', '<C-W><C-H>', {noremap=true, silent=true})

-- Super hacky plugin to shell out to github.com/kinbiko/kokodoko and fetch the
-- Github link to the current line(s)
-- Yes, that is an undo of the automatic replacing of text in the visual
-- mapping...
map('n', 'oiuy', ':!kokodoko % <C-R>=line(".")<CR><CR>', {noremap=true, silent=true})
map('v', 'oiuy', [[:!kokodoko % <C-R>=line("'<")<CR>-<C-R>=line("'>")<CR><CR>u]], {noremap=true, silent=true})
