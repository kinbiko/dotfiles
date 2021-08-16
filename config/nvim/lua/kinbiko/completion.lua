vim.cmd[[
" Use <Tab> and <S-Tab> to navigate through popup menu
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <right> pumvisible() ? "\<C-n>" : "\<right>"
imap <expr> <left> pumvisible() ? "\<C-p>" : "\<left>"
imap <expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
imap <expr> <up> pumvisible() ? "\<C-p>" : "\<up>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

]]
