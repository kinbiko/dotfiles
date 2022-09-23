-- Set the colorscheme
vim.cmd('colorscheme tokyonight-night')

local o = vim.o

-- Setting this explicitly means I can copy Japanese to the clipboard without mojibake
-- There's no non-vim.cmd solution for this as of 2021-08-20 according to tjdevries.
vim.cmd('lang en_US.UTF-8')

o.tabstop = 2 -- columns per tab character
o.softtabstop = 2 -- columns per tab key press in insert mode. Also on backspace
o.shiftwidth = 2 -- columns per 'indent', used for <, >, and =
o.expandtab = true -- converts tabs to spaces
o.shiftround = true -- When indenting, round to a multiple of shiftwidth

-- Let vim decide indentation rules by default. Used for files with no filetype
-- settings, filetype specific config files may overwrite this.
o.autoindent = true

o.scrolloff=8      -- Number of lines from vertical edge to start scroll
o.sidescrolloff=15 -- Number of lines from horizontal edge to start scroll
o.sidescroll=6     -- Number of columns to scroll at a time

o.incsearch=true  -- search as chars are entered
o.hlsearch=true   -- highlight matches
o.ignorecase=true -- Case insensitive search
o.smartcase=true  -- except when explicitly using capital letters

o.inccommand = 'nosplit' -- Make substitute previews immediately

-- Create new splits to the right and to the below
o.splitbelow = true
o.splitright = true

-- Display relative line numbers apart from the current line.
o.relativenumber = true
o.number = true

-- Disable backups
o.backup = false
o.writebackup = false

o.swapfile = false -- Disable swap files

o.timeoutlen=300 -- Time to wait in milliseconds between hitting the first key of a multi-key mapping
o.ttimeoutlen=0  -- Ensure that there's no delay between esc-ing and the next command executing

o.lazyredraw = true --Don't attempt to render macros for example

o.autoread = true -- Automatically read file when edited outside of vim

o.backspace = 'indent,eol,start' -- Make deleting natural

o.wrap = false -- Don't wrap lines by default

-- How to represent non-printable characters. In general, don't want tabs, so
-- have them show up as special characters.
o.listchars='tab:>-,trail:·,extends:>,precedes:<'
o.list = true -- turn the above on

o.shortmess = o.shortmess .. 'I' -- Disable the 'welcome' message on starting without a path

o.autowrite = true -- Make No write since last change stfu

-- Allows you to hide a buffer without saving it
o.hidden = true

-- Disable the statusline
o.showmode = false
o.ruler = false
o.laststatus = 0
o.showcmd = false

o.formatoptions= o.formatoptions .. 'j' -- Behave more reasonable when merging lines with J

-- Define the window border characters for splits etc.
o.fillchars = o.fillchars .. 'vert:│,fold: ,diff: '

-- Disable the netrw history file which is otherwise added to ~/.vim/.netrwhist
vim.g.netrw_dirhistmax = 0

-- Ensure that I can enter markdown checkboxes without generating a double
-- space like this: [  ]. (should only have a single space inside when hitting
-- space)
vim.g.lexima_enable_space_rules = 0

-- required by nvim-cmp
vim.o.completeopt='menu,menuone,noselect'

-- Don't exit tmux zoom mode if attempting to navigate out of vim
vim.g.tmux_navigator_disable_when_zoomed = 1
