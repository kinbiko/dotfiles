local setg = vim.api.nvim_set_var

-- Ensure that I can enter markdown checkboxes without generating a double
-- space like this: [  ]. (should only have a single space inside when hitting
-- space)
setg('lexima_enable_space_rules', 0)

vim.cmd([[
colorscheme nord
" Setting this explicitly means I can copy Japanese to the clipboard without mojibake
lang en_US.UTF-8
set tabstop=2 "columns per tab character
set softtabstop=2 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=2 "columns per 'indent', used for <, >, and =
set expandtab "converts tabs to spaces
set shiftround "When indenting, round to a multiple of shiftwidth
"Let vim decide indentation rules by default.
"Used for files with no filetype specific settings, filetype specific config
"files may overwrite this.
set autoindent

set scrolloff=8 "Number of lines from vertical edge to start scroll
set sidescrolloff=15 "Number of lines from horizontal edge to start scroll
set sidescroll=6 "Number of columns to scroll at a time

set incsearch "search as chars are entered
set hlsearch "highlight matches
set ignorecase "Case insensitive search
set smartcase  "except when explicitly using capital letters

" Make substitute previews immediately
set inccommand=nosplit

set splitbelow "New splits below, not above
set splitright "New splits on the right, not left

set relativenumber "Linenumbers are relative to current line
set number "Display the actual line number for the current line

set wildmenu "makes the command-line completion better

set nobackup "Disable backups
set nowritebackup
set noswapfile "Disable swap files

"Time to wait in milliseconds between hitting the first key of a multi-key mapping
set timeoutlen=300
"Ensure that there's no delay between esc-ing and the next command executing
set ttimeoutlen=0
set lazyredraw "Don't attempt to render macros for example
set autoread "Automatically read file when edited outside of vim
set backspace=indent,eol,start "Make deleting natural
set nowrap "Don't wrap lines by default
filetype plugin indent on "Enable plugin- and filetype indent
syntax enable "Use syntax highlighting by default

" Disable the netrw history file which is otherwise added to ~/.vim/.netrwhist
let g:netrw_dirhistmax = 0

"How to represent non-printable characters. In general, don't want tabs, so have them show up as special characters.
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list "turn the above on

"Allows you to hide a buffer without saving it
set hidden

set formatoptions+=j

" Disable statusline
set noshowmode
set noruler
set laststatus=0
set noshowcmd

"Tell vim we support 256 colours
set t_Co=256

"Character to use in splits, etc.
set fillchars+=vert:│,fold:\ ,diff:\ 

for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

"Make comments red. This must be below other style configs to have an effect.
highlight comment ctermfg=DarkRed
]])
