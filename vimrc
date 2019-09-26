"{{{ Setup plugins
set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"{{{ Themes and looks
Plug 'arcticicestudio/nord-vim' "Nord theme
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
"}}}

"{{{ Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "File tree on the left hand side
Plug 'easymotion/vim-easymotion' "Accurate navigation ala vimium
Plug 'haya14busa/vim-asterisk' "Use * without moving immediately
Plug '/usr/local/opt/fzf' "Put fzf on the path so that it can be used by
Plug 'junegunn/fzf.vim' "The lightning fast fzf fuzzy finder
"}}}

"{{{ Git
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*
Plug 'rhysd/committia.vim' "Running 'git commit' on the command line enables diff and other niceties
"}}}

"{{{ Surrounding syntax
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .
Plug 'cohama/lexima.vim' "Automatically close [], '' etc. including def/end
"}}}

"{{{ Misc.
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
"}}}

"{{{ Languages
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'html', 'xml', 'jsx', 'erb'] } "Shortcuts for creating html/jsx boilerplate
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' } "Make vim good with go. Master branch is dev branch, so should use specific release instead
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'json'] } "prettier formatter
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'json'] } "Makes syntax highlighting etc. more sane for js.
Plug 'elzr/vim-json', {'for': ['javascript', 'json'] } "JSON syntax (error) highlighting + concealment
Plug 'mxw/vim-jsx', {'for': ['javascript', 'json', 'jsx'] } "Support for JSX
"""}}}

"{{{ Neovim specific
if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
"}}}


" Really belongs under 'Themes and looks' but its README requests that it's loaded last
Plug 'ryanoasis/vim-devicons' "Pretty icons per filetype

call plug#end()
"}}}

"{{{ Style

colorscheme nord

let g:rehash256=1

"}}}

"{{{ Plugin configs

"{{{ NERDTree
" Prevent fluff from appearing in the file drawer
let NERDTreeIgnore=['node_modules$', '\~$', '\.git$', '\.DS_Store$', '\.meta$']
" Show hidden files in NERDTree
let NERDTreeShowHidden=1
" Ignore the help-instructions at the top of NERDTree
let NERDTreeMinimalUI=1
" Delete the NERDTree buffer when it's the only one left
let NERDTreeAutoDeleteBuffer=1
"}}}

if has('nvim')

"{{{ COC

  " The README for this project contains a comprehensive config
  " This section has been heavily stripped and modified from the suggested
  " config there.

  " Use tab for trigger completion with characters ahead and navigate.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Used by pumvisible
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<CR>'
"}}}

endif

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

"}}}

"{{{ Writing
"{{{ Typos in :commands
if has("user_commands")
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Q q<bang>
endif
"}}}

"{{{ ABBREVIATIONS
iabbrev teh the
iabbrev adn and
"}}}

"}}}

"{{{ Mappings
let mapleader = ' '
let maplocalleader = ','

" Keys I rarely use in normal mode (OK to overwrite):
nnoremap W :echo "vimrc: W is unmapped"<CR>
nnoremap E :echo "vimrc: E is unmapped"<CR>
nnoremap t :echo "vimrc: t is unmapped"<CR>
nnoremap Y :echo "vimrc: Y is unmapped"<CR>
nnoremap [ :echo "vimrc: \[ is unmapped"<CR>
nnoremap ] :echo "vimrc: \] is unmapped"<CR>
nnoremap H :echo "vimrc: H is unmapped"<CR>
nnoremap K :echo "vimrc: K is unmapped"<CR>
nnoremap L :echo "vimrc: L is unmapped"<CR>
nnoremap \\ :echo "vimrc: backslash is unmapped"<CR>
nnoremap \| :echo "vimrc: pipe is unmapped"<CR>
nnoremap Z :echo "vimrc: Z is unmapped"<CR>
nnoremap X :echo "vimrc: X is unmapped"<CR>
nnoremap M :echo "vimrc: M is unmapped"<CR>

" Switch to previous buffer. Does not switch to unopened arg buffers
nnoremap <localleader>. :b#<CR>
" Clear current search-highlight
nnoremap <localleader><leader> :nohlsearch<CR>
" Toggle NERDTree
nnoremap <silent> <localleader><localleader> :NERDTreeToggle<CR>
nnoremap <silent> ., :NERDTreeFind<CR>

" Jump back and forth between tags
nnoremap <leader>[ <C-t>
nnoremap <leader>] g<C-]>

" Find using vimium-like search feature
nmap <leader>f <Plug>(easymotion-prefix)s

" Create a blank line above/below current line
nnoremap <leader>j o<ESC>k
nnoremap <leader>k O<ESC>j

" Swap function arguments left/right
nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>l :SidewaysRight<CR>

" Undo unstaged Git hunk
nnoremap <leader>u :GitGutterUndoHunk<cr>

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
vnoremap < <gv
vnoremap > >gv

" Move to the next/previous completely empty line in buffer. Will still work as 'enter' when given a menu buffer with options, e.g. :Ag
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

" Open file, but ignore gitignored files with ?
" If the directory is not a repo it will show all files
" Grabbed from Dorian Karter https://www.youtube.com/watch?v=aXPQTesFdTI
fun! FindMeFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles -co -- ':!:vendor'
  endif
endfun

nnoremap ? :call FindMeFiles()<CR>
nnoremap B :Buffer<CR>
nnoremap <silent> T :Tags <C-R><C-W><CR>

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

"}}}

"{{{ General

"{{{ Indentation
set tabstop=2 "columns per tab character
set softtabstop=2 "columns per tab key press in insert mode. Also on backspace
set shiftwidth=2 "columns per 'indent', used for <, >, and =
set expandtab "converts tabs to spaces
set shiftround "When indenting, round to a multiple of shiftwidth
"Let vim decide indentation rules by default.
"Used for files with no filetype specific settings, filetype specific config
"files may overwrite this.
set autoindent
"}}}

"{{{ Scrolling
set scrolloff=8 "Number of lines from vertical edge to start scroll
set sidescrolloff=15 "Number of lines from horizontal edge to start scroll
set sidescroll=6 "Number of columns to scroll at a time
"}}}

"{{{ Search
set incsearch "search as chars are entered
set hlsearch "highlight matches
set ignorecase "Case insensitive search
set smartcase  "except when explicitly using capital letters

"nvim only
if has('nvim')
  " Make substitute previews immediately
  set inccommand=nosplit
endif
"}}}

"{{{ Splits
set splitbelow "New splits below, not above
set splitright "New splits on the right, not left
"}}}

"{{{ Line numbers
set relativenumber "Linenumbers are relative to current line
set number "Display the actual line number for the current line
"}}}

"{{{ Command mode
set wildmenu "makes the command-line completion better
set confirm "instead of aborting because of unsaved changes, ask
set cmdheight=1 "set the command line height to 1
"}}}

"{{{ Vim autogenerated files

set nobackup "Disable backups
set nowritebackup
set noswapfile "Disable swap files

"Enable vim state to be persisted between sessions
"E.g. command history/search/registers etc.
"comma separated arguments list of:
" ! - Global variables in CONSTANT_CASE
" % - Buffer list
" ' - Maximum number of files to remember for marks. Must be included
" / - Max number of search patterns to remember. Applies to :%s as well
" : - Max number of commands to remember
" < - Ommitted => include all lines from registers
" @ - Max number of input-line items to remember (for prompts)
" c - Encoding for the viminfo file
" f - Whether or not to store file marks
" h - Whether to disable hlsearch when loading
" n - name (path) of the viminfo file
" r - concrete settings to ignore marks in files in removable media
" s - Max size of a register item in Kbyte.

" Ensure nvim local viminfo files are kept separate to regular vim viminfo files
if !has("nvim")
  set viminfo='50,<1000,s100,:100,/100,%5,n~/.vim-local/viminfo
else
  set viminfo='50,<1000,s100,:100,/100,%5
endif

"}}}

"{{{ Misc.
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

"How to represent non-printable characters
"In general, don't want tabs, so have them show up as special characters
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list "turn the above on

"Allows you to hide a buffer without saving it
set hidden

"Make J smarter with comments
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set laststatus=2 " Always display the statusline in all windows

" Make help always open veritcally
if !exists("*OpenHelp80Cols")
  function OpenHelp80Cols()
      wincmd L
      " Slightly larger than 80 characters to allow for w-ing through a help
      " file without bouncing left and right
      exec 'vertical resize 93'
  endfunction
  autocmd FileType help :call OpenHelp80Cols()
endif

"Highlight what part of the text has changed when doing a vimdiff
if !has("nvim")
  set highlight+=N:DiffText
endif

"Tell vim we support 256 colours
set t_Co=256

"Character to use between buffers, overrides the vertial line between windows
"to be continuous, folds to not have a repeating dashed line and diffs to be
"based on colour alone
set fillchars+=vert:│,fold:\ ,diff:\ 

" When opening a file again, go to the last location of that file
augroup go_to_last_location_in_file
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup end
"}}}

for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

"}}}

"Make comments red. This must be below other style configs to have an effect.
highlight comment ctermfg=DarkRed

" The following paths are loaded automatically, but listed here for gf-ing.
" ~/.vim/after/ftplugin/coffee.vim
" ~/.vim/after/ftplugin/dockerfile.vim
" ~/.vim/after/ftplugin/gitcommit.vim
" ~/.vim/after/ftplugin/go.vim
" ~/.vim/after/ftplugin/html.vim
" ~/.vim/after/ftplugin/java.vim
" ~/.vim/after/ftplugin/javascript.vim
" ~/.vim/after/ftplugin/markdown.vim
" ~/.vim/after/ftplugin/proto.vim
" ~/.vim/after/ftplugin/ruby.vim
" ~/.vim/after/ftplugin/vim.vim
" ~/.vim/after/ftplugin/xml.vim
" ~/.vim/after/ftplugin/yaml.vim
