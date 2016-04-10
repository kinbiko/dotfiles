execute pathogen#infect()

filetype plugin indent on "Enable filetype plugins
syntax enable "Use syntax highlighting by default
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Syntastic readme told me to do this as a default
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Solarized colorscheme stuff:
let g:solarized_termcolors=256 "Ensure proper colors
let g:solarized_termtrans=1 "Makes the terminal transparency 1, i.e. black
set background=dark
colorscheme solarized


set wildmenu "makes the command-line completion better
set hlsearch "Highlight searches
set ignorecase "Case insensitive search
set smartcase  "except when explicitly using capital letters
set autoindent "Used for files with no filetype specific settings
set ruler "Display the curser position in the bottom right corner
set confirm "instead of aboring because of unsaved changes, ask
set cmdheight=2 "set the command line height to 2
set number "Display line numbers
set autoread "Automatically read file when edited outside of vim

"Indentation
set shiftwidth=4
set softtabstop=4
set expandtab

"Habit breakers
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Run on startup
autocmd vimenter * NERDTree "Automatically launch NERDTree on startup

" Turn backup off, as it makes gitignore cleaner
set nobackup
set nowb
set noswapfile
