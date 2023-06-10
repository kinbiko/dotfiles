-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " " -- This is already the LazyVim default, but explicitly stating again for clarity.
vim.g.maplocalleader = "," -- This is ' ' by default as LazyVim has it defined.

local i = "i"
local n = "n"
local o = "o"
local v = "v"

-- Silent, noremap
local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, remap = false }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Make arrow key navigation more useful
-- Note to the reader: I've programmed a second layer on my ergodox keyboard to
-- map hjkl to the arrow keys. So even when I do use the arrow keys my fingers
-- don't leave the home row.
map("", "<up>", "{") -- Previous paragraph
map("", "<down>", "}") -- Next paragraph
map(n, "0", "^") -- Make 0 take me to the first non-blank character of the line.
map(n, "'", "`") -- Make jumping to a mark more precise than just the beginning of the line in normal mode
map(o, "'", "`") -- Make jumping to a mark more precise than just the beginning of the line when awaiting an operator

-- NOTE: LazyVim tries hard to overwrite this mapping when lazy loading the (disabled) leap.nvim plugin.
map(n, "s", "<cmd>w<cr>") -- Quick-save the current buffer

map(n, "<right>", "gd", { silent = true }) -- Go to definition
map(n, "<left>", "<c-o>", { silent = true }) -- Pop back up
map(n, "n", "nzz") -- Make forward search results always appear in the middle of the screen
map(n, "N", "Nzz") -- Make backward search results always appear in the middle of the screen
map(n, "+", "<c-a>") -- Intuitive increment
map(n, "-", "<c-x>") -- Intuitive decrement

-- NOTE: Resist the temptation to rewrite ":" to "<cmd>" as these mappings require a closing <cr>.
-- Also trying to silence it prevents the command mode from being visible.
map(n, ";", ":", { noremap = true }) -- Conveniently enter command mode

map(v, "Y", '"*y') -- Copy to the system clipboard
map(v, ">", ">gv") -- indent lines and remember the selection
map(v, "L", ">gv") -- indent lines and remember the selection
map(v, "<", "<gv") -- dedent lines and remember the selection
map(v, "H", "<gv") -- dedent lines and remember the selection
map(n, "Q", "@@") -- Execute the last played macro
map(i, "jk", "<esc>") -- Easy access to normal mode from insert mode
map(n, "<C-C>", "<cmd>cclose<cr>") -- Close the quickfix window
map(n, "<leader>G", ':!kokodoko % <C-R>=line(".")<CR><CR>') -- Fetch link to current line in GitHub
map(v, "<leader>G", [[:!kokodoko % <C-R>=line("'<")<CR>-<C-R>=line("'>")<CR><CR>u]]) -- Fetch link to selected lines in GitHub

map(n, "S", "ysiw", { silent = true, remap = true }) -- Surround the current word with the following character
map("", "*", "<Plug>(asterisk-z*)zz") -- Make * mark the current word and n will go forward
map("", "#", "<Plug>(asterisk-z#)zz") -- Make # mark the current work and n will go backward
map(n, "<leader>R", "<cmd>Twilight<cr>") -- Read the code with focus on one section at the time

-- TODO: Figure out how to smoothly change into a tmux window from vim

--[[ TODO: Change the telescope live_grep and lsp_references feature to ignore mock and test files.
vim.keymap.set("n", "?S", function() -- Pop open a window for grepping for any text in the repo
  require("telescope.builtin").live_grep({
    glob_pattern = "!*{mock*,_test.go}"
  })
end)
vim.keymap.set("n", "?R", function() -- Pop open a window for finding references to the word under the cursor
  require("telescope.builtin").lsp_references({
    glob_pattern = "!*{mock*,_test.go}",
  })
end)
--]]
