"{{{ Setup plugins
set nocompatible  "required
filetype off      "required

call plug#begin('~/.vim/plugged')

"{{{ Themes and looks
Plug 'arcticicestudio/nord-vim' "Nord theme
"}}}

"{{{ Navigation
Plug 'scrooloose/nerdtree' "File tree on the left hand side
Plug 'Xuyuanp/nerdtree-git-plugin' "Nerdtree + git highlighting
Plug 'wincent/terminus' "Cursor changes in different modes, mouse support
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' "fzf in vim
Plug 'rking/ag.vim' "search inside files
Plug 'easymotion/vim-easymotion' "Accurate navigation ala vimium
Plug 'haya14busa/vim-asterisk' "Use * without moving immediately
Plug 'majutsushi/tagbar' "Tag bar on the right
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
Plug 'cohama/lexima.vim' "Like autoclose + endwise
"}}}

"{{{ Linting
Plug 'bronson/vim-trailing-whitespace' "Mark trailing whitespace
Plug 'w0rp/ale' "Async linting engine
"}}}

"{{{ Tmux
Plug 'christoomey/vim-tmux-navigator' "Work better with tmux
Plug 'benmills/vimux' "Integrate with tmux easily
"}}}

"{{{ Misc.
Plug 'sickill/vim-pasta' "Context aware pasting + intentation
Plug 'godlygeek/tabular' "Make aligning nice and pretty. Must be before plasticboy/vim-markdown
Plug 'metakirby5/codi.vim' "in-vim coding scratchpad/repl
Plug 'AndrewRadev/switch.vim'
Plug 'vim-scripts/BufOnly.vim' "Close all buffers apart from this one with :Bonly
"}}}

"{{{ Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' } "Make vim good with go. Master branch is dev branch, so use latest release instead
Plug 'ap/vim-css-color' "Make css colours appear in editor in that colour
Plug 'prettier/vim-prettier' "prettier formatter
Plug 'pangloss/vim-javascript' "Makes syntax highlighting etc. more sane for js.
Plug 'elzr/vim-json' "JSON highlighting + concealment
Plug 'mxw/vim-jsx' "Support for JSX
Plug 'plasticboy/vim-markdown' "Amazing markdown support
Plug 'uarun/vim-protobuf' "Mmmm protobuf files.
Plug 'keith/rspec.vim' "Make _spec.rb files nicer
Plug 'cespare/vim-toml' "For as long as I use dep when writing go
Plug 'stephpy/vim-yaml' "Delete this if there's no real use for it
"""}}}

call plug#end()
"}}}

"{{{ Style

colorscheme nord

"Make comments red. This must be below other style configs to have an effect.
" FIXME: doesn't currently work - all comments are grey
highlight comment ctermfg=DarkRed

"{{{ SYNTASTIC

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '無'
let g:syntastic_warning_symbol = '悪'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

"}}}

let g:rehash256=1

"}}}

"{{{ Plugin configs

"{{{ AUTOCLOSE
"Configure autoclose
let g:AutoClosePairs = "() {} \" `"
"This would have put spaces on both sides inside brackets, but
"breaks vim abbreviations when followed by space.
let g:AutoCloseExpandSpace = 0
"}}}
"{{{ NERDTREE
" Prevent fluff from appearing in the file drawer
let NERDTreeIgnore=['node_modules$', '\~$', '\.git$', '\.DS_Store$', '\.meta$']
" Show hidden files in NERDTree
let NERDTreeShowHidden=1
" Ignore the help-instructions at the top of NERDTree
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

let g:NERDTreeDisableFileExtensionHighlight = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:orange
let g:NERDTreeExtensionHighlightColor['js'] = s:blue
let g:NERDTreeExtensionHighlightColor['go'] = s:orange
let g:NERDTreeExtensionHighlightColor['java'] = s:darkBlue
let g:NERDTreeExtensionHighlightColor['groovy'] = s:green
let g:NERDTreeExtensionHighlightColor['rb'] = s:red
let g:NERDTreeExtensionHighlightColor['json'] = s:blue
let g:NERDTreeExtensionHighlightColor['vim'] = s:white
let g:NERDTreeExtensionHighlightColor['xml'] = s:beige
let g:NERDTreeExtensionHighlightColor['gradle'] = s:beige

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['Dockerfile'] = s:red " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
"}}}

"{{{ ALE
let g:ale_sign_error = '嫌'
let g:ale_sign_warning = '臭'

let g:ale_fixers = {
\  'ruby': ['rubocop'],
\}
"}}}

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

"{{{ Tagbar
let g:tagbar_autoclose = 1
"}}}

" {{{ VIM-GO

" Only use quickfix windows
let g:go_list_type = "quickfix"

" }}}
" }}}

"{{{ Writing
"{{{ TYPOS
if has("user_commands")
  command! -bang -nargs=? -complete=file E e<bang> <args>
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
let mapleader = ','
let maplocalleader = ' '

"{{{Normal mode mappings

"{{{ File Navigation
"
"Flip between files with ,.
noremap <leader>. :b#<CR>

"Follow and return from ctagged files
nnoremap ] g<C-]>
nnoremap [ <C-t>

"Fuzzy-find any file in this git repo with ?
nnoremap ? :GFiles<CR>

"Move to next/previous git hunks
nnoremap <c-N> :GitGutterNextHunk<cr>
nnoremap <c-P> :GitGutterPrevHunk<cr>

"}}}

"{{{ Editor navigation

"Make H be home, L be end
"Actually map these, and not just noremap, as $ and 0 are annoying to find sometimes
map H ^
map L $
nnoremap j gj
nnoremap k gk

"Navigate vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Make dem evil keys do chores
noremap <Up> :N<CR>
noremap <Down> :n<CR>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

"Literally the best keybindings I know
nnoremap <BS> {
onoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'

"F toggles vimium-like search
nmap F <Plug>(easymotion-prefix)s

map # <Plug>(asterisk-z*)
map * <Plug>(asterisk-z#)

"Because :w is too annoying
nnoremap s :w<CR>

"Next error/warning
nnoremap <silent> <leader>e <Plug>(ale_next_wrap)
nnoremap <silent> <leader>f :ALEFix<cr>

"If I had a nickel for every time I mistyped that combo
"... I'd have a lot of low-valued American coins
nmap S ysiw
"}}}

"Make a vertical split with vv
nnoremap <silent> vv :vsp <CR>
"Make a horizontal split with VV
nnoremap <silent> VV :sp <CR>

"Insert blank lines without insert mode
nnoremap t o<ESC>k
nnoremap T O<ESC>j
"Make Q repeat the last recorded marcro
nnoremap Q @@

"Simplify getting to command mode
nnoremap ; :
"I rarely use marks anyway, and probably wanted to hit ;
nnoremap ' :

"Clear the search highlights
nnoremap <leader><space> :nohlsearch<CR>

"Leader + v opens vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

"Leader + Leader opens nerd tree.
nnoremap <silent> <leader><leader> :NERDTreeToggle<CR>

"Change the current word to be UPPERCASE on U
"TODO: Switch from simple upper case to CONSTANT_CASE
nnoremap U vawUew

"Perform git-undo
nnoremap <c-U> :GitGutterUndoHunk<cr>

nnoremap m :Switch<CR>

"open/close folds entirely
nnoremap zz zA

" Delete current buffer with local leader
nnoremap <silent> <localleader><localleader> :bp\|bd #<CR>

"Wait, why isn't this the default?
nnoremap + <C-a>
nnoremap - <C-x>

" Open a temporary tagbar for quick naviation with \
nnoremap \ :TagbarToggle<CR>

" Generate tags with leader + t. This command is somewhat slutty
nnoremap <leader>t :!ctags -R **/*<CR>

" Make it easier to jump between errors in quickfix list
nnoremap <silent> <c-o> :cnext<CR>
nnoremap <silent> <c-i> :cprevious<CR>
nnoremap <silent> <c-c> :cclose<CR>

"}}}

"{{{Visual mode mappings

"Align blocks of text and keep them selected
vnoremap < <gv
vnoremap > >gv

vnoremap jk <esc>

vnoremap <BS> {
vnoremap <CR> }
"}}}

"{{{ Insert-mode mappings

"Good for when CAPS-LOCK can't be mapped to escape.
inoremap jk <esc>

"Auto-complete with tab
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"}}}

"{{{ Operator-pending mappings

onoremap q i"
onoremap Q a"

"Make 'inside array' be a movement
onoremap ia i]
onoremap aa a]

"}}}

"{{{ List of keys that are available for mapping to:
"Shift-tab (Cannot use just tab in normal mode for terminal reasons)
"m as marks are unused
"}}}

"}}}

"{{{ General

"{{{ Folding
set foldenable "Enable folding

set foldlevelstart=9 "Shows most folds by default
set foldnestmax=5 "You're writing bad code if you need to up this one
set foldmethod=indent "Fold based on indentation.
"}}}

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
"Uncomment the below if odd files appear a lot
"set nowritebackup "Don't write pre-save backup files

set noswapfile "Disable swap files

"Enable persisted undo history
set undofile
set undodir=~/.vim-local/undofiles/

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
"Ensure that there's no delay between esc-ing and the next command executing
set timeoutlen=300 ttimeoutlen=0
set lazyredraw "only redraw when needed
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
      exec 'vertical resize 81'
  endfunction
  autocmd FileType help :call OpenHelp80Cols()
endif

"Add fzf to the runtime path
set rtp+=/usr/local/opt/fzf

set highlight+=N:DiffText

set t_Co=256 "Tell vim we support 256 colours

set fillchars+=vert:│

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
