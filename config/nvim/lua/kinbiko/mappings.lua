-- Keys I rarely use in normal mode (OK to overwrite):
-- t E L M X Y Z [ ] |

local map = vim.api.nvim_set_keymap

local snr = {noremap = true, silent = true}

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Make arrow key navigation more useful
-- Note to the reader: I've programmed a second layer on my ergodox keyboard to
-- map hjkl to the arrow keys. So even when I do use the arrow keys my fingers
-- don't leave the home row.
map('', '<up>', '{', snr) -- Previous paragraph
map('', '<down>', '}', snr) -- Next paragraph
map('n', '<localleader>.', '<cmd>b#<cr>', snr) -- Switch to the previous buffer.
map('n', '<localleader><leader>', '<cmd>nohlsearch<CR>', snr) -- Clear the current search highlight
map('n', '<leader>f', '<Plug>Lightspeed_omni_s', {}) -- Find using vimium-like search feature

-- Pop open a window for quickly finding various things:
map('n', '?F', '<cmd>Telescope find_files<cr>', snr) -- Search across lots of files relative to current directory, respecting .gitignore
vim.keymap.set("n", "?S", function() -- Pop open a window for grepping for any text in the repo
  require("telescope.builtin").live_grep({
    glob_pattern = "!*{mock*,_test.go}"
  })
end)
map('n', '?R', '<cmd>Telescope lsp_references<cr>', snr) -- Pop open a window for finding references to the word under the cursor

map('n', '?I',  '<cmd>Telescope lsp_implementations<cr>', snr) -- Find implementations of an interface
map('n', '?W', '<cmd>Telescope grep_string<cr>', snr) -- Live grep for the word under the cursor

map('n', '0', '^', snr) -- Make 0 take me to the first non-blank character of the line.
map('n', "'", '`', snr) -- Make jumping to a mark more precise than just the beginning of the line in normal mode
map('o', "'", '`', snr) -- Make jumping to a mark more precise than just the beginning of the line when awaiting an operator
map('n', '<right>', 'gd', { silent = true }) -- Go to definition
map('n', '<left>', '<c-o>', { silent = true }) -- Pop back up
map('', '*', '<Plug>(asterisk-z*)zz', {silent=true}) -- Make * mark the current word and n will go forward
map('', '#', '<Plug>(asterisk-z#)zz', {silent=true}) -- Make # mark the current work and n will go backward
map('n', 'n', 'nzz', snr) -- Make forward search results always appear in the middle of the screen
map('n', 'N', 'Nzz', snr) -- Make backward search results always appear in the middle of the screen
map('n', '+', '<c-a>', snr) -- Intuitive increment
map('n', '-', '<c-x>', snr) -- Intuitive decrement
map('n', ';', ':', {noremap=true}) -- Conveniently enter command mode
map('v', 'Y', '"*y', snr) -- Copy to the system clipboard
map('v', '>', '>gv', snr) -- indent lines and remember the selection
map('n', '>', '>>', snr) -- indent lines and remember the selection
map('v', 'L', '>gv', snr) -- indent lines and remember the selection
map('v', '<', '<gv', snr) -- dedent lines and remember the selection
map('n', '<', '<<', snr) -- dedent lines and remember the selection
map('v', 'H', '<gv', snr) -- dedent lines and remember the selection
map('v', 'p', '"_dP', snr) -- Execute the last played macro
map('n', 'Q', '@@', snr) -- Execute the last played macro
map('n', 'S', 'ysiw', {silent=true}) -- Surround the current word with the following character
map('n', 'j', 'gj', snr) -- Move down wrapped lines intuitively, not literally
map('n', 'k', 'gk', snr) -- Move down wrapped lines intuitively, not literally
map('i', 'jk', '<esc>', snr) -- Easy access to normal mode from insert mode
map('n', 's', '<cmd>w<cr>', {noremap=true}) -- Quick-save the current buffer
map('n', '<C-J>', '<C-W><C-J>', snr) -- More easily switch window downwards
map('n', '<C-K>', '<C-W><C-K>', snr) -- More easily switch window upwards
map('n', '<C-L>', '<C-W><C-L>', snr) -- More easily switch window right
map('n', '<C-H>', '<C-W><C-H>', snr) -- More easily switch window left
map('n', '<C-C>', '<cmd>cclose<cr>', snr) -- Close the quickfix window
map('n', '<leader><esc>', '<cmd>cclose<cr>', snr) -- Close the quickfix window
map('n', '<leader>G', ':!kokodoko % <C-R>=line(".")<CR><CR>', snr) -- Fetch link to current line in GitHub
map('v', '<leader>G', [[:!kokodoko % <C-R>=line("'<")<CR>-<C-R>=line("'>")<CR><CR>u]], snr)-- Fetch link to selected lines in GitHub
map('n', '<leader>R', '<cmd>Twilight<cr>', snr) -- Read the code with focus on one section at the time.
map('i', '<C-\\>', '<Plug>luasnip-expand-or-jump', {}) -- Trigger snippet insertion
map('n', '<localleader>g', '<cmd>G<cr>', snr) -- Show interactive Git status so you don't need to leave vim.
map('n', '<leader>b', '<cmd>GitMessenger<cr>', snr) -- Open popup of git commit info.
