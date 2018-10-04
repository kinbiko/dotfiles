"{{{ Setup plugins
set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"{{{ Themes and looks
Plug 'arcticicestudio/nord-vim' "Nord theme
"}}}

"{{{ Navigation
Plug 'scrooloose/nerdtree' "File tree on the left hand side
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' "fzf in vim
Plug 'easymotion/vim-easymotion' "Accurate navigation ala vimium
Plug 'haya14busa/vim-asterisk' "Use * without moving immediately
"}}}

"{{{ Git
Plug 'airblade/vim-gitgutter' "Makes the git gutter with +, ~, and - available
Plug 'tpope/vim-fugitive' "Most git features available through :G*
Plug 'rhysd/committia.vim' "git commit becomes magic
"}}}

"{{{ Surrounding syntax
Plug 'mattn/emmet-vim' "Shortcuts for creating html/jsx boilerplate
Plug 'tpope/vim-surround' "ysiw syntax for surrounding
Plug 'tpope/vim-repeat' "Make vim-surround things repeatable with .
Plug 'cohama/lexima.vim' "Automatically close [], '' etc. including def/end
"}}}

"{{{ Misc.
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
Plug 'w0rp/ale' "Async linting engine
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
Plug 'godlygeek/tabular' "Make aligning nice and pretty. Must be before plasticboy/vim-markdown
Plug 'AndrewRadev/switch.vim' "switch between true/false, string/symbol etc.
Plug 'vim-scripts/BufOnly.vim' "Close all buffers apart from this one with :Bonly
"}}}

"{{{ Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' } "Make vim good with go. Master branch is dev branch, so use latest release instead
Plug 'prettier/vim-prettier' "prettier formatter
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'elzr/vim-json' "JSON highlighting + concealment
Plug 'mxw/vim-jsx' "Support for JSX
Plug 'plasticboy/vim-markdown' "Amazing markdown support, including header folding and concealment
"""}}}

call plug#end()
"}}}

"{{{ Style

colorscheme nord

"Make comments red. This must be below other style configs to have an effect.
" FIXME: doesn't currently work - all comments are grey
highlight comment ctermfg=DarkRed

let g:rehash256=1

"}}}

"{{{ Plugin configs

"{{{ NERDTREE
" Prevent fluff from appearing in the file drawer
let NERDTreeIgnore=['node_modules$', '\~$', '\.git$', '\.DS_Store$', '\.meta$']
" Show hidden files in NERDTree
let NERDTreeShowHidden=1
" Ignore the help-instructions at the top of NERDTree
let NERDTreeMinimalUI=1
" Delete the NERDTree buffer when it's the only one left
let NERDTreeAutoDeleteBuffer=1

"}}}

"{{{ ALE
let g:ale_sign_error = '嫌'
let g:ale_sign_warning = '臭'

let g:ale_fixers = {
\  'ruby': ['rubocop'],
\  'javascript': ['eslint'],
\}
"}}}

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

" }}}

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

"==========================================================================================
" Mapping        |   Mode   | Meaning and comments
"==========================================================================================
" <local>.        |  Normal  | Switch to previous buffer. Does not switch to unopened arg buffers
" <local><leader> |  Normal  | Clear current search-highlight
" <local><local>  |  Normal  | Toggle NERDTree
" <local>v        |  Normal  | Open vimrc

" <leader><leader>|  Normal  | Close current buffer
" <leader>V       |  Normal  | Make a horizontal split
" <leader>[       |  Normal  | Jump back from previous tag jump
" <leader>]       |  Normal  | Jump to ctagged definition.
" <leader>f       |  Normal  | Find using vimium-like search feature
" <leader>j       |  Normal  | Create a blank line below
" <leader>k       |  Normal  | Create a blank line above
" <leader>m       |  Normal  | Switch between options, e.g. true/false, 's'/:s
" <leader>n       |  Normal  | Go to next unstaged Git hunk
" <leader>p       |  Normal  | Go to previous unstaged Git hunk
" <leader>u       |  Normal  | Undo unstaged Git hunk
" <leader>v       |  Normal  | Make a vertical split
" <leader>z       |  Normal  | Open or close a fold completely

" The following bindings are happily mapped over their native vim option, as I
" either find the build in feature pretty useless, or not quite right
" #               | !Insert  | Highlight the current word, but do not move to next instance. Continue with n
" *               | !Insert  | Highlight the current word, but do not move to previous instance. Continue with n
" +               |  Normal  | Increment the next number on this line
" -               |  Normal  | Decrement the next number on this line
" ;               |  Normal  | Convenience key for getting to command mode
" <>              |  Visual  | In/de-dent lines and remember selection
" <backspace>     | !Insert  | Move to the previous completely empty line in buffer
" <enter>         | !Insert  | Move to the next completely empty line in buffer. Will still work as 'enter' when given a menu buffer with options, e.g. :Ag
" <left>          |  Normal  | Switch to previous buffer
" <right>         |  Normal  | Switch to next buffer
" <tab>           |  Insert  | Show autocomplete options
" ?               |  Normal  | Fuzzy find file by filename in the current Git repo. TODO: Make this also find newly added files that aren't tracked yet by Git
" H               |  All     | Move to the first non-blank character on this line
" L               |  All     | Move to the last character on this line
" Q               |  Normal  | Execute the last played macro
" S               |  Normal  | Surround current word with next character
" j               |  Normal  | Move down one line, moving to wrapped lines if applicable
" jk              |  All     | Enter normal mode
" k               |  Normal  | Move up one line, moving to wrapped lines if applicable
" s               |  Normal  | Save the current buffer

" <c-hjkl>        |  Normal  | Switch window in the given direction. Switches to tmux windows if applicable

nnoremap <localleader>. :b#<CR>
nnoremap <localleader><leader> :nohlsearch<CR>
nnoremap <localleader>v :e $MYVIMRC<CR>
nnoremap <silent> <localleader><localleader> :NERDTreeToggle<CR>

nnoremap <silent> <lleader><lleader> :bp\|bd #<CR>
nnoremap <leader>[ <C-t>
nnoremap <leader>] g<C-]>
nnoremap <silent> <leader>V :sp <CR>
vnoremap <silent> <leader>v :vsp <CR>
nmap <leader>f <Plug>(easymotion-prefix)s
nnoremap <leader>j o<ESC>k
nnoremap <leader>k O<ESC>j
nnoremap <leader>m :Switch<CR>
nnoremap <leader>n :GitGutterNextHunk<cr>
nnoremap <leader>p :GitGutterPrevHunk<cr>
nnoremap <leader>u :GitGutterUndoHunk<cr>
nnoremap <leader>z zA

nnoremap ? :GFiles<CR>
map H ^
map L $
nnoremap j gj
nnoremap k gk
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }
nnoremap s :w<CR>
nmap S ysiw
map # <Plug>(asterisk-z*)
map * <Plug>(asterisk-z#)
nnoremap Q @@
nnoremap ; :
nnoremap + <C-a>
nnoremap - <C-x>
vnoremap < <gv
vnoremap > >gv
vnoremap jk <esc>
inoremap jk <esc>
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

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

set viminfo='50,<1000,s100,:100,/100,%5,n~/.vim-local/viminfo

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
      " Slightly larger than 80 charaacers to allow for w-ing through a help
      " file without bouncing left and right
      " TODO: make this window exactly 80 characters, but disable horizontal
      " scrolling for help windows
      exec 'vertical resize 93'
  endfunction
  autocmd FileType help :call OpenHelp80Cols()
endif

"Add fzf to the runtime path
set rtp+=/usr/local/opt/fzf

"Highlight what part of the text has changed when doing a vimdiff
set highlight+=N:DiffText

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

" Tab toggles auto-complete
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

"}}}

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
