-- Set the colorscheme
vim.g.colors_name = 'nord'

-- Setting this explicitly means I can copy Japanese to the clipboard without mojibake
-- TODO: Find the *right* config option (not vim.cmd) for this -- it's too
-- annoying to google and all the config options on the global vim namespace
-- are implemented with magic.
vim.cmd('lang en_US.UTF-8')

vim.o.tabstop = 2 -- columns per tab character
vim.o.softtabstop = 2 -- columns per tab key press in insert mode. Also on backspace
vim.o.shiftwidth = 2 -- columns per 'indent', used for <, >, and =
vim.o.expandtab = true -- converts tabs to spaces
vim.o.shiftround = true -- When indenting, round to a multiple of shiftwidth

-- Let vim decide indentation rules by default. Used for files with no filetype
-- settings, filetype specific config files may overwrite this.
vim.o.autoindent = true

vim.o.scrolloff=8      -- Number of lines from vertical edge to start scroll
vim.o.sidescrolloff=15 -- Number of lines from horizontal edge to start scroll
vim.o.sidescroll=6     -- Number of columns to scroll at a time

vim.o.incsearch=true  -- search as chars are entered
vim.o.hlsearch=true   -- highlight matches
vim.o.ignorecase=true -- Case insensitive search
vim.o.smartcase=true  -- except when explicitly using capital letters

vim.o.inccommand = 'nosplit' -- Make substitute previews immediately

-- Create new splits to the right and to the below
vim.o.splitbelow = true
vim.o.splitright = true

-- Display relative line numbers apart from the current line.
vim.o.relativenumber = true
vim.o.number = true

vim.o.wildmenu = true -- makes the command-line completion better

-- Disable backups
vim.o.backup = false
vim.o.writebackup = false

vim.o.swapfile = false -- Disable swap files

vim.o.timeoutlen=300 -- Time to wait in milliseconds between hitting the first key of a multi-key mapping
vim.o.ttimeoutlen=0  -- Ensure that there's no delay between esc-ing and the next command executing

vim.o.lazyredraw = true --Don't attempt to render macros for example

vim.o.autoread = true -- Automatically read file when edited outside of vim

vim.o.backspace = 'indent,eol,start' -- Make deleting natural

vim.o.wrap = false -- Don't wrap lines by default

-- How to represent non-printable characters. In general, don't want tabs, so
-- have them show up as special characters.
vim.o.listchars='tab:>-,trail:·,extends:>,precedes:<'
vim.o.list = true -- turn the above on

-- Allows you to hide a buffer without saving it
vim.o.hidden = true

-- Disable the statusline
vim.o.showmode = false
vim.o.ruler = false
vim.o.laststatus = 0
vim.o.showcmd = false

vim.o.formatoptions= vim.o.formatoptions .. 'j' -- Behave more reasonable when merging lines with J

-- Define the window border characters for splits etc.
vim.o.fillchars = vim.o.fillchars .. 'vert:│,fold: ,diff: '

-- Disable the netrw history file which is otherwise added to ~/.vim/.netrwhist
vim.g.netrw_dirhistmax = 0

-- Ensure that I can enter markdown checkboxes without generating a double
-- space like this: [  ]. (should only have a single space inside when hitting
-- space)
vim.g.lexima_enable_space_rules = 0

-- The .spl files are ignored by default, because they're ugly binary files.
-- However, these files should be regenerated based on the .add files which are
-- committed and may be changed on different computers.
-- Based on https://stackoverflow.com/q/27240638/2422278
-- TODO: Rewrite in Lua
vim.cmd([[
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor
]])
