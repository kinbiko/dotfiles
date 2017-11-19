let mapleader = ','

"{{{ Special intellij mappings <3
nnoremap ] :action GotoDeclaration<CR>
nnoremap [ :action Back<CR>
nnoremap ? :action SearchEverywhere<CR>

nnoremap <leader><leader> :action ActivateProjectToolWindow<CR>
"}}}

nmap <BS> {
nmap <CR> }

nnoremap vv :vsp<CR>
nnoremap VV :sp<CR>

nmap t o<ESC>k
nmap T O<ESC>j

nmap Q @@

nnoremap j gj
nnoremap k gk

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap ; :

vmap <BS> {
vmap <CR> }

vnoremap jk <esc>

vmap < <gv
vmap > >gv

nnoremap * #
nnoremap # *

inoremap jk <esc>
