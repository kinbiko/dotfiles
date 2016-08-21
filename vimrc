source ~/.vim/vimplugins

"======== Fun settings =============
" Set what the leader key is
let mapleader = ","

set relativenumber

"======== Leader mappings============
"Leader + space = clear the damn highlights for the last search
nnoremap <leader><space> :nohlsearch<CR>
" Leader + v opens vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
"Leader + Leader opens nerd tree. TODO: can this be made smarter?
nnoremap <leader><leader> :NERDTreeToggle<CR>
" make buffer switching easier
nnoremap <leader>f :buffers<CR>:b

" Git status on leader + s
nnoremap <leader>s :Gstatus<CR>
" Git blame on leader + b
nnoremap <leader>b :Gblame<CR>
" Git commit on leader + c
nnoremap <leader>c :Gcommit<CR>
" Git push on leader + pull
nnoremap <leader>push :Gpush<CR>
" Git pull on leader + pull
nnoremap <leader>pull :Gpull<CR>

"make leader + . return to previous file
noremap <leader>. :b#<CR>

"======= Normal mode remappings =========
"Remap space to open/close folds
nnoremap <space> za
"Movement (up down disabled, left right moves between open buffers)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>
"Move vertically to wrapped line
nnoremap j gj
nnoremap k gk

"insert blank lines without insert mode
nmap t o<ESC>k
nmap T O<ESC>j

"Use E and B instead of $ and ^
nnoremap B ^
nnoremap E $
"Make H be home, L be end
noremap H ^
noremap L $
"Make semicolon do what you normally need colon to do
nnoremap ; :

"Navigate vim splits with CTRL + h/j/k/l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Make Q repeat the last recorded marcro
nmap Q @@

"========== Insert mode remappings ================
" Make jk do the same as escape. Good for when I can't have CAPS-LOCK map to
" escape.
inoremap jk <esc>
" Make Emmet available through h + h
imap hh <C-y>

"Move around in insert mode using ctrl + hjkl
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
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
set foldmethod=indent

"Searching
set incsearch "search as chars are entered
set hlsearch "highlight matches

" Turn backup off, as it makes gitignore cleaner
set nobackup
set nowb
set noswapfile

"Adjust the scrolling:
"Number of lines from vertical edge to start scroll
set scrolloff=8
"Number of lines from horizontal edge to start scroll
set sidescrolloff=15
"Number of columns to scroll at a time
set sidescroll=1

" make deleting natural
set backspace=indent,eol,start

" associate *.fileending with filetype
filetype plugin indent on "Enable plugin- and filetype indent
syntax enable "Use syntax highlighting by default

"Make vim open new splits to the right and bottom
set splitbelow
set splitright

"Run python current file (+ give arguments)
map <leader>r <CR>:!python %

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"remove the buffer status line text.
map <Leader>t :MBEToggle<cr>:MBEFocus<cr>
nnoremap <Leader><Right> :MBEbn<cr>
nnoremap <Leader><Left> :MBEbp<cr>
nnoremap <Leader>w :MBEbd<cr>
let g:miniBufExplBuffersNeeded = 1
let g:miniBufExplCloseOnSelect = 1
let g:miniBufExplShowBufNumbers = 0

"Make nerdtree more 'mine'
let NERDTreeIgnore=['node_modules$', '\.git$', '\.DS_Store$', '\.meta$']
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

"Configure autoclose
let g:AutoClosePairs = "() {} \" `"

"Make leader+V resource the vimrc
nnoremap <Leader>V :source ~/.vimrc<cr>

"Ensure that there's no delay between esc-ing and the next command executing
set timeoutlen=1000 ttimeoutlen=0
