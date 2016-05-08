call pathogen#helptags()
execute pathogen#infect()

filetype plugin indent on "Enable plugin- and filetype indent
syntax enable "Use syntax highlighting by default
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Leader
let mapleader = ","
"Consider enabling this one in windows:
"inoremap jk <esc>

"Syntastic readme told me to do this as a default
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

colorscheme molokai
let g:molokai_original=1
let g:rehash256=1

set lazyredraw "only redraw when needed
set wildmenu "makes the command-line completion better
set ignorecase "Case insensitive search
set smartcase  "except when explicitly using capital letters
set autoindent "Used for files with no filetype specific settings
set ruler "Display the curser position in the bottom right corner
set confirm "instead of aboring because of unsaved changes, ask
set cmdheight=2 "set the command line height to 2
set number "Display line numbers
" set cursorline "Highlight the current line
set autoread "Automatically read file when edited outside of vim

"Indentation
set tabstop=2 "number of VISUAL SPACES per tab
set softtabstop=2 "Number of spaces per tab when editing
set expandtab "converts tabs to spaces
set shiftwidth=2 
"Movement
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"Move vertically to wrapped line
nnoremap j gj
nnoremap k gk
"Use E and B instead of $ and ^
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

"Folding
set foldenable "Enable folding
set foldlevelstart=10 "Shows most folds by default
set foldnestmax=10 "You're writing bad code if you need to up this one
"Remap space to open/close folds
nnoremap <space> za

"Searching
set incsearch "search as chars are entered
set hlsearch "highlight matches
"Leader + space = clear the damn highlights for the last search
nnoremap <leader><space> :nohlsearch<CR>

" Turn backup off, as it makes gitignore cleaner
set nobackup
set nowb
set noswapfile

" Ensure that there's no delay between esc-ing and the next command executing
set timeoutlen=1000 ttimeoutlen=0

" make bracket handling easier
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap < <><Esc>i
inoremap [ []<Esc>i
