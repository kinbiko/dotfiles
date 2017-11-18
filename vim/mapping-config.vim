let mapleader = ','
let maplocalleader = ' '

""{{{Normal mode mappings

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

"Enable camelcase navigation for word
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

"Make H be home, L be end
noremap H ^
noremap L $
nnoremap j gj
nnoremap k gk

"Navigate vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Evil keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

"Literally the best keybindings I know
nnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'

"Space bar toggles easy-motion search
map 888 <Plug>(easymotion-prefix)
nmap f 888s

map # <Plug>(asterisk-z*)
map * <Plug>(asterisk-z#)

"Because :w is too annoying
nnoremap s :w<CR>
"}}}

"Make a vertical split with vv, and go to tag if on one
nnoremap <silent> vv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"Make a horizontal split with VV, and go to tag if on one
nnoremap <silent> VV :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"Insert blank lines without insert mode
nnoremap t o<ESC>k
nnoremap T O<ESC>j
"Make Q repeat the last recorded marcro
nnoremap Q @@

"Simplify getting to :Ex mode
nnoremap ; :

"Clear the search highlights
nnoremap <leader><space> :nohlsearch<CR>

"Leader + v opens vimrc
nnoremap <leader>v :vsplit $MYVIMRC<CR>
"Leader + V sources the vimrc
nnoremap <leader>V :source $MYVIMRC<CR>

"Leader + Leader opens nerd tree.
nnoremap <silent> <leader><leader> :NERDTreeToggle<CR>

nnoremap <leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

nnoremap U vawUew

"Perform git-undo
nnoremap <c-U> :GitGutterUndoHunk<cr>

"}}}

"{{{Visual mode mappings

"Align blocks of text and keep them selected
vnoremap < <gv
vnoremap > >gv

vnoremap jk <esc>

"Make // seach for the currently selected words
vnoremap // y/<C-R>"<CR>

vnoremap <BS> {
vnoremap <CR> }
"}}}

"{{{ Insert-mode mappings

"Good for when CAPS-LOCK can't be mapped to escape.
inoremap jk <esc>

"}}}

"{{{ Operator-pending mappings

"Make 'inside quotes' be a movement
"These may be swapped for languages where strings are usually written with
"double quotes, e.g. Java
onoremap q i'
onoremap Q i"

"Make 'inside array' be a movement
onoremap ia i]
onoremap aa a]

"}}}

"{{{ Command mode mappings

"Map any !shell commands to clear the console first
:map :! :!clear;

"}}}

"{{{ List of keys that are available for mapping to:
"U - don't usually want to do a photoshop-undo
"Up and down arrow keys
"Shift-tab (Cannot use just tab in normal mode for terminal reasons)
"}}}
