let mapleader = ',' "leader == ,

"=== File Navigation ===
"Flip between files with ,.
noremap <leader>. :b#<CR>
"Use gt and gb to follow and return from ctagged files TODO:1
nnoremap gt <C-]>
nnoremap gb <C-t>

"=== Editor navigation ===
"Make H be home, L be end
noremap H ^
noremap L $
"Navigate vim splits with CTRL + h/j/k/l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"=== Git shortcuts ===
"status = leader + s
nnoremap <leader>s :Gstatus<CR>
"blame  = leader + b
nnoremap <leader>b :Gblame<CR>

"Remap space to open/close folds
nnoremap <space> za

"=== Evil keys ===
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>

"=== Wrapping ===
nnoremap j gj
nnoremap k gk

"=== Quick Edit ===
"Insert blank lines without insert mode
nmap t o<ESC>k
nmap T O<ESC>j
"Make Q repeat the last recorded marcro
nmap Q @@
"Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
"Make cl. insert a console log statement
inoremap cl. console.log();<ESC>jkhha
"Make control + = insert a hashrocket

"=== Mode switching ===
"Make semicolon do what you normally need colon to do
nnoremap ; :
"Make jk == escape. Good for when CAPS-LOCK can't be mapped to escape.
inoremap jk <esc>

"Clear the search highlights
nnoremap <leader><space> :nohlsearch<CR>
"Make // in visual mode seach for the currently selected words
vnoremap // y/<C-R>"<CR>

nnoremap <BS> {
nnoremap <CR> }

"=== .vimrc ===
"Leader + v opens vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
"Make leader+V resource the vimrc
nnoremap <Leader>V :source ~/.vimrc<cr>

"Map any !shell commands to clear the console first
:map :! :!clear;

"=== Plugin shortcuts ===
"Make Emmet available through h + h
imap hh <C-y>

"Leader + Leader opens nerd tree.
nnoremap <leader><leader> :NERDTreeToggle<CR>
