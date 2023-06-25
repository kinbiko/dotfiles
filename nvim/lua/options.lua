vim.cmd.lang("en_US.UTF-8") -- Setting this explicitly means I can copy Japanese to the clipboard without mojibake

-- Don't put these in keymaps.lua as they get loaded too late for plugins to know what the leaders are.
vim.g.mapleader = " " -- This is already the LazyVim default, but explicitly stating again for clarity.
vim.g.maplocalleader = "," -- This is ' ' by default as LazyVim has it defined.

vim.g.netrw_dirhistmax = 0 -- Disable the netrw history file which is otherwise added to ~/.vim/.netrwhist
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

local o = vim.opt

-- Allow for directives in sourcecode to adjust vim settings, e.g.
-- # vim: syntax=toml:
-- in git config files etc.
o.modeline = true

o.autowrite = true -- Make No write since last change stfu
o.completeopt = "menu,menuone,noselect"
o.conceallevel = 3 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = false -- Disable highlighting of current line
o.expandtab = true -- Use spaces instead of tabs
o.fillchars = { vert = "│", eob = " ", diff = " ", fold = " " } -- Define the window border characters for splits etc.
o.formatoptions = "jcroqlnt" -- tcqj
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.hidden = true -- Allows you to hide a buffer without saving it
o.ignorecase = true -- Ignore case
o.inccommand = "nosplit" -- preview incremental substitute
o.laststatus = 0
o.list = false -- Don't show "shadow" symbols for whitespace since I've got formatters for basically all the files I open.
o.number = true -- Print line number
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.relativenumber = true -- Relative line numbers
o.scrolloff = 8 -- Number of lines from vertical edge to start scroll
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
o.shiftround = true -- Round indent
o.shiftwidth = 4 -- Size of an indent
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false -- Dont show mode since we have a statusline
o.sidescroll = 6 -- Number of columns to scroll at a time
o.sidescrolloff = 15 -- Number of lines from horizontal edge to start scroll
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.softtabstop = 4 -- spaces per tab key press in insert mode. Also on backspace
o.spelllang = { "en" }
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.swapfile = false -- Disable swap files
o.tabstop = 4 -- Number of columns per tab character
o.termguicolors = true -- True color support
o.timeoutlen = 300
o.ttimeoutlen = 0 -- Ensure that there's no delay between esc-ing and the next command executing
o.undolevels = 10000
o.updatetime = 200 -- Save swap file and trigger CursorHold
o.wildmode = "longest:full,full" -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width
o.wrap = false -- Disable line wrap
