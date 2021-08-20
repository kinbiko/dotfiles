-- Use <Tab> and <S-Tab> to navigate through popup menu
-- TODO: figure out how to do pumvisible() + ternaries in lua mappings
vim.cmd[[
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <right> pumvisible() ? "\<C-n>" : "\<right>"
imap <expr> <left> pumvisible() ? "\<C-p>" : "\<left>"
imap <expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
imap <expr> <up> pumvisible() ? "\<C-p>" : "\<up>"
]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. 'c'
