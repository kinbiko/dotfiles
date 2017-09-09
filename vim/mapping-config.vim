let mapleader = ','

"=== File Navigation ===
"Flip between files with ,.
noremap <leader>. :b#<CR>
"Follow and return from ctagged files
nnoremap ] <C-]>
nnoremap [ <C-t>

"=== Editor navigation ===
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

nnoremap <leader>b :Gblame<CR>

"=== Evil keys ===
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

"=== Quick Edit ===
"Insert blank lines without insert mode
nmap t o<ESC>k
nmap T O<ESC>j
"Make Q repeat the last recorded marcro
nmap Q @@
"Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

"=== Mode switching ===
"Simplify getting to :Ex mode
nnoremap ; :
"Good for when CAPS-LOCK can't be mapped to escape.
inoremap jk <esc>
vnoremap jk <esc>

"Clear the search highlights
nnoremap <leader><space> :nohlsearch<CR>
"Make // in visual mode seach for the currently selected words
vnoremap // y/<C-R>"<CR>

"Literally the best keybindings I know
nmap <BS> {
nmap <CR> }

vmap <BS> {
vmap <CR> }

"=== .vimrc ===
"Leader + v opens vimrc
nnoremap <leader>v :e ~/.vimrc<CR>

"Map any !shell commands to clear the console first
:map :! :!clear;

nnoremap ? :BLines<CR>
nnoremap <C-t> :GFiles<CR>
nnoremap <Space> :Tags<CR>
nnoremap <C-o> :BTags<CR>
nnoremap <C-f> :AgBuffer! 
nnoremap <leader>f :Buffer<cr>

"Make a vertical split with vv, and go to tag if on one
nnoremap <silent> vv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"Make a horizontal split with VV, and go to tag if on one
nnoremap <silent> VV :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"Leader + Leader opens nerd tree.
nnoremap <silent> <leader><leader> :NERDTreeToggle<CR>

"Make this buffer the only buffer
nnoremap <leader>o :w\|%bd\|e#<cr>

"=== List of keys that are available for mapping to:
"U - don't usually want to do a photoshop-undo
"Up and down (left and right too)
