local i = "i"
local n = "n"
local o = "o"
local v = "v"
local x = "x"

local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, remap = false }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map({ n, x }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ n, x }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map(n, "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map(n, "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map(n, "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map(n, "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map(n, "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- When writing long things in text, it's nice to be able to undo more partially.
map(i, ",", ",<c-g>u")
map(i, ".", ".<c-g>u")
map(i, ";", ";<c-g>u")

-- stylua: ignore start

map(n, "<leader>us", function() require("util").toggle("spell") end, { desc = "Toggle Spelling" })
map(n, "<leader>uw", function() require("util").toggle("wrap") end, { desc = "Toggle Word Wrap" })
map(n, "<leader>ud", require("util").toggle_diagnostics, { desc = "Toggle Diagnostics" })
map(n, "<leader>gg", function() require("util").float_term({ "lazygit" }, { cwd = require("util").get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- TODO: Change to use the repository root
map(n, "\\", function() require("util").float_term(nil, { cwd = require("util").get_root() }) end, { desc = "Terminal (root dir)" })

-- stylua: ignore end

-- Make arrow key navigation more useful
-- Note to the reader: I've programmed a second layer on my ergodox keyboard to
-- map hjkl to the arrow keys. So even when I do use the arrow keys my fingers
-- don't leave the home row.
map("", "<up>", ":keepjumps normal {zz<cr>") -- Previous paragraph
map("", "<down>", ":keepjumps normal }zz<cr>") -- Next paragraph
map(n, "0", "^") -- Make 0 take me to the first non-blank character of the line.
map(n, "'", "`") -- Make jumping to a mark more precise than just the beginning of the line in normal mode
map(o, "'", "`") -- Make jumping to a mark more precise than just the beginning of the line when awaiting an operator

map(n, "<C-h>", [[<cmd>lua require('tmux').move_left()<cr>]])
map(n, "<C-j>", [[<cmd>lua require('tmux').move_down()<cr>]])
map(n, "<C-k>", [[<cmd>lua require('tmux').move_up()<cr>]])
map(n, "<C-l>", [[<cmd>lua require('tmux').move_right()<cr>]])

map(n, "s", "<cmd>w<cr>") -- Quick-save the current buffer

map(n, "<right>", "gd", { silent = true }) -- Go to definition
map(n, "<left>", "<c-o>", { silent = true }) -- Pop back up
map(n, "n", "nzz") -- Make forward search results always appear in the middle of the screen
map(n, "N", "Nzz") -- Make backward search results always appear in the middle of the screen

-- NOTE: Resist the temptation to rewrite ":" to "<cmd>" as these mappings require a closing <cr>.
-- Also trying to silence it prevents the command mode from being visible.
map(n, ";", ":", { remap = true }) -- Conveniently enter command mode

map(v, "Y", '"*y') -- Copy to the system clipboard
map(v, ">", ">gv") -- indent lines and remember the selection
map(v, "L", ">gv") -- indent lines and remember the selection
map(v, "<", "<gv") -- dedent lines and remember the selection
map(v, "H", "<gv") -- dedent lines and remember the selection
map(n, "Q", "@@") -- Execute the last played macro
map(i, "jk", "<esc>") -- Easy access to normal mode from insert mode
map(n, "<C-C>", "<cmd>cclose<cr>") -- Close the quickfix window
map(n, "<leader>gk", ':!kokodoko % <C-R>=line(".")<CR><CR>') -- Fetch link to current line in GitHub
map(v, "<leader>gk", [[:!kokodoko % <C-R>=line("'<")<CR>-<C-R>=line("'>")<CR><CR>u]]) -- Fetch link to selected lines in GitHub

map(n, "S", "ysiw", { silent = true, remap = true }) -- Surround the current word with the following character
map("", "*", "<Plug>(asterisk-z*)zz") -- Make * mark the current word and n will go forward
map("", "#", "<Plug>(asterisk-z#)zz") -- Make # mark the current work and n will go backward
