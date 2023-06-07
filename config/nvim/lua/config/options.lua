-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim sets this to 'unnamedplus' which pollutes the system clipboard for every yank/delete/etc.
-- This unsets this.
vim.opt.clipboard = ""

vim.cmd.lang("en_US.UTF-8") -- Setting this explicitly means I can copy Japanese to the clipboard without mojibake

vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Make normal text transparent
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Make normal text in non-current windows transparent
vim.api.nvim_set_hl(0, "Visual", { bg = "none", fg = "yellow" }) -- Make visually selected text yellow

local o = vim.o

o.softtabstop = 2 -- columns per tab key press in insert mode. Also on backspace
o.scrolloff = 8 -- Number of lines from vertical edge to start scroll
o.sidescrolloff = 15 -- Number of lines from horizontal edge to start scroll
o.sidescroll = 6 -- Number of columns to scroll at a time
o.swapfile = false -- Disable swap files
o.ttimeoutlen = 0 -- Ensure that there's no delay between esc-ing and the next command executing
o.autowrite = true -- Make No write since last change stfu
o.hidden = true -- Allows you to hide a buffer without saving it

-- How to represent non-printable characters. In general, don't want tabs, so
-- have them show up as special characters.
o.listchars = "tab:>-,trail:·,extends:>,precedes:<"

-- Define the window border characters for splits etc.
o.fillchars = o.fillchars .. "vert:│,fold: ,diff: "

-- Disable the netrw history file which is otherwise added to ~/.vim/.netrwhist
vim.g.netrw_dirhistmax = 0