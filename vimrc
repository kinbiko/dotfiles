source ~/.vim/vimplugins

"======== Super important settings =============
" Set what the leader key is
let mapleader = ","

"======== Leader mappings============
"Leader + space = clear the damn highlights for the last search
nnoremap <leader><space> :nohlsearch<CR>
" Leader + v opens vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
"Leader + Leader opens nerd tree. TODO: can this be made smarter?
nnoremap <leader><leader> :NERDTree<CR>
" make buffer switching easier
nnoremap <leader>f :buffers<CR>:buffer<Space>

"======= Normal mode remappings =========
"Remap space to open/close folds
nnoremap <space> za
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
"Make semicolon do what you normally need colon to do
nnoremap ; :
" Make r replace more than one character by default.
noremap R r
noremap r R

"========== Insert mode remappings ================
" Make jk do the same as escape. Good for when I can't have CAPS-LOCK map to
" escape.
inoremap jk <esc>
" Make Emmet available through h + h
imap hh <C-y>

"============= Visual mode remappings=============
" make // in visual mode seach for the currently selected words
vnoremap // y/<C-R>"<CR>

"Associate file ending .hbs with html
au BufNewFile,BufRead *.hbs setlocal ft=html
"Associate file ending .psl with Groovy
au BufNewFile,BufRead *.psl setlocal ft=groovy
"Associate file vimplugins with vim
au BufNewFile,BufRead vimplugins setlocal ft=vim
" Associate file .kata with Groovy
au BufNewFile,BufRead *.kata setlocal ft=groovy
" Associate file .style with Groovy
au BufNewFile,BufRead *.style setlocal ft=groovy

"==================Common typos===================
if has("user_commands")
  command! -bang -nargs=? -complete=file E e<bang> <args>
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Q q<bang>
endif

"==================Boring necessities==============

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
set tabstop=4 "number of VISUAL SPACES per tab
set softtabstop=4 "Number of spaces per tab when editing
set expandtab "converts tabs to spaces
set shiftwidth=4

"Folding
set foldenable "Enable folding
set foldlevelstart=10 "Shows most folds by default
set foldnestmax=10 "You're writing bad code if you need to up this one

"Searching
set incsearch "search as chars are entered
set hlsearch "highlight matches

" Turn backup off, as it makes gitignore cleaner
set nobackup
set nowb
set noswapfile

" make deleting natural
set backspace=indent,eol,start

" associate *.fileending with filetype
filetype plugin indent on "Enable plugin- and filetype indent
syntax enable "Use syntax highlighting by default
"Status line setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Ensure that there's no delay between esc-ing and the next command executing
set timeoutlen=1000 ttimeoutlen=0
