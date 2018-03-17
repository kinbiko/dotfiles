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
