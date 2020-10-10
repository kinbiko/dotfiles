set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim' "Nord theme
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "File tree on the left hand side
Plug 'easymotion/vim-easymotion' "Accurate navigation ala vimium
Plug 'haya14busa/vim-asterisk' "Use * without moving immediately
Plug '/usr/local/opt/fzf' "Put fzf on the path so that it can be used by
Plug 'junegunn/fzf.vim' "The lightning fast fzf fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*
Plug 'rhysd/committia.vim' "Running 'git commit' on the command line enables diff and other niceties
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .
Plug 'cohama/lexima.vim' "Automatically close [], '' etc. including def/end
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'machakann/vim-highlightedyank' "Highlight when yanking so you don't need to pop into visual mode constantly
Plug 'sickill/vim-pasta' "Context aware pasting + indentation
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'html', 'xml', 'jsx', 'erb', 'markdown', 'typescript'] } "Shortcuts for creating html/jsx boilerplate
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' } "Make vim good with go.
Plug 'rust-lang/rust.vim' " Official Rust plugin.
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'json', 'css', 'markdown', 'md', 'typescript'] } "prettier formatter
Plug 'elzr/vim-json', {'for': ['javascript', 'json'] } "JSON syntax (error) highlighting + concealment
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language Server Protocol client
Plug 'ryanoasis/vim-devicons' "Pretty icons per filetype. Must be loaded last.

call plug#end()

" Setting this explicitly means I can copy Japanese to the clipboard without
" mojibake
lang en_US.UTF-8

colorscheme nord

let g:rehash256=1

let NERDTreeIgnore=['node_modules$', '\~$', '\.git$', '\.DS_Store$', '\.meta$', 'tags$', 'tags.lock$', 'tags.temp$', '.idea$', '.env$']
let NERDTreeShowHidden=1
" Ignore the help-instructions at the top of NERDTree
let NERDTreeMinimalUI=1
" Delete the NERDTree buffer when it's the only one left
let NERDTreeAutoDeleteBuffer=1

" How long after the last keypress that CursorHold events execute.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

" Mappings using CoCList:
nnoremap E :CocList diagnostics<cr>
nnoremap <leader>c :CocCommand<cr>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-leader> pumvisible() ? "<C-n>" : coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Ensure that I can enter markdown checkboxes without generating a double
" space like this: [  ]. (should only have a single space inside when hitting
" space)
let g:lexima_enable_space_rules=0

let g:coc_config_home='~/repos/dotfiles/vim/coc-settings.json'

if has("user_commands")
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Q q<bang>
endif

iabbrev teh the
iabbrev adn and

let mapleader = ' '
let maplocalleader = ','

" Keys I rarely use in normal mode (OK to overwrite):
" tags: unused not used available
" t E K L M X Y Z [ ] \ | <left> <right>

" Make 0 take me to the first non-blank character of the line.
nnoremap 0 ^

" Make marks be more precise with '
onoremap ' `
nnoremap ' `

" Make arrow key navigation more useful
" Reader Note: I've programmed a second layer on my ergodox keyboard to map
" hjkl to the arrow keys. So even when I do use the arrow keys (as defined
" below) I don't leave the home row :)
nnoremap <up> {
vnoremap <up> {
onoremap <up> {
nnoremap <down> }
vnoremap <down> }
onoremap <down> }

" Switch to previous buffer. Does not switch to unopened arg buffers
nnoremap <localleader>. :b#<CR>
" Clear current search-highlight
nnoremap <localleader><leader> :nohlsearch<CR>
nnoremap <silent> <localleader><localleader> :NERDTreeToggle<CR>
nnoremap <silent> .<localleader> :NERDTreeFind<CR>

" Jump back and forth between tags
nnoremap <leader>[ <C-t>
nnoremap <leader>] g<C-]>

" Find using vimium-like search feature
nmap <leader>f <Plug>(easymotion-prefix)s

nnoremap ? :Files<CR>

" Undo unstaged Git hunk
nnoremap <leader>u :GitGutterUndoHunk<cr>

" ctrl + j,k is more intuitive to me than ctrl + n,p
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Highlight current word, and prepare to cycle through with n. # is forwards, * is backwards
map # <Plug>(asterisk-z*)zz
map * <Plug>(asterisk-z#)zz

" Make search results always appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" Increment/Decrement the next number on this line
nnoremap + <C-a>
nnoremap - <C-x>

" Convenience key for getting to command mode
nnoremap ; :

" Copy to the clipboard with Y
vnoremap Y "*y

" In/de-dent lines and remember selection
vnoremap H <gv
vnoremap L >gv

" Execute the last played macro
nnoremap Q @@

" Surround current word with next character
nmap S ysiw

" Move up/down one line, moving to wrapped lines if applicable
nnoremap j gj
nnoremap k gk

" Enter normal mode
inoremap jk <esc>

" Save the current buffer
nnoremap s :w<CR>

" Switch window in the given direction. Switches to tmux windows if applicable
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
