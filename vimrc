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
Plug 'ludovicchabant/vim-gutentags' "Regenerate the tags file automatically
Plug 'yuki-ycino/fzf-preview.vim' "Preview when finding stuff with fzf
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
Plug 'prettier/vim-prettier', { 'for': ['javascript', 'json', 'markdown', 'md'] } "prettier formatter
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

inoremap <C-j> <down>
inoremap <C-k> <up>

if has('nvim')
  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

"{{{ COC
  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif


  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"}}}

endif

"Make jsx syntax show up in .js files
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1 "Makes css/html syntax available in .js files(React)

" Rate of fzf window as a number between 0 and 1.
" This opens the window in full screen.
" Use ctrl+s to fullscreen
let g:fzf_preview_rate = 0.2

" Change the default value from u/d to l/r
let g:fzf_preview_default_key_bindings = 'ctrl-l:preview-page-down,ctrl-h:preview-page-up,?:toggle-preview'

" Ensure that I can enter markdown checkboxes without generating a double
" space like this: [  ]. (should only have a single space inside when hitting
" space)
let g:lexima_enable_space_rules=0
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

" Make arrow key navigation more useful
" Reader Note: I've programmed a second layer on my ergodox keyboard to map
" hjkl to the arrow keys. So even when I do use the arrow keys (as defined
" below) I don't leave the home row :)
nnoremap <right> w
nnoremap <left> b
nnoremap <up> {
nnoremap <down> }
vnoremap <right> w
vnoremap <left> b
vnoremap <up> {
vnoremap <down> }
onoremap <right> w
onoremap <left> b
onoremap <up> {
onoremap <down> }

" Switch to previous buffer. Does not switch to unopened arg buffers
nnoremap <localleader>. :b#<CR>
" Clear current search-highlight
nnoremap <localleader><leader> :nohlsearch<CR>
" Toggle NERDTree
nnoremap <silent> <localleader><localleader> :NERDTreeToggle<CR>
" Find file in current buffer in NERDTree
nnoremap <silent> ., :NERDTreeFind<CR>

" Jump back and forth between tags
nnoremap <leader>[ <C-t>
nnoremap <leader>] g<C-]>

" Find using vimium-like search feature
nmap <leader>f <Plug>(easymotion-prefix)s

" Create a blank line above/below current line
nnoremap <leader>j o<ESC>k
nnoremap <leader>k O<ESC>j

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

nnoremap <silent> ? :<C-u>FzfPreviewProjectFiles<CR>
nnoremap <silent> B :FzfPreviewAllBuffers<CR>
nnoremap <silent> T :Tags <C-R><C-W><CR> !_test.go !mock

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

" Open notes repo with Ctrl+W
nnoremap <C-W> :Files ~/repos/notes/<CR>

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
"Commented as it collides with FzfPreview
"set confirm "instead of aborting because of unsaved changes, ask
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


"I also wwant to add the following to the end of cut: | cut -s -f4- -d":" | awk '{$1=$1;print}'
command! -bang -nargs=? -complete=dir Ag call fzf#vim#ag(<q-args>, {'options': ['--layout=reverse', '--preview', 'echo {} | cut -s -f4- -d":"']}, <bang>0)
