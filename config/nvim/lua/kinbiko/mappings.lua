-- Keys I rarely use in normal mode (OK to overwrite):
-- t E L M X Y Z [ ] \ |

local map = vim.api.nvim_set_keymap

local silentnoremap = {noremap = true, silent = true}

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

map('n', '0', '^', silentnoremap) -- Make 0 take me to the first non-blank character of the line.

-- More precise marks by default
map('n', "'", '`', silentnoremap)
map('o', "'", '`', silentnoremap)

-- Make arrow key navigation more useful
-- Note to the reader: I've programmed a second layer on my ergodox keyboard to
-- map hjkl to the arrow keys. So even when I do use the arrow keys my fingers
-- don't leave the home row.
map('', '<up>', '{', silentnoremap)
map('', '<down>', '}', silentnoremap)

-- Switch to the previous buffer.
map('n', '<localleader>.', ':b#<cr>', silentnoremap)

-- Clear the current search highlight
map('n', '<localleader><leader>', ':nohlsearch<CR>', silentnoremap)

-- Find using vimium-like search feature
map('n', '<leader>f', '<Plug>(easymotion-prefix)s', {})

-- Pop open a window for grepping for filename under the current directory.
-- Useful big searches across lots of repos from a parent directory
map('n', '?F', ':Files<cr>', silentnoremap)
-- Pop open a window for finding code actions for the current cursor location
map('n', '?A', ':Ag<cr>', silentnoremap)

-- Pop open a window for grepping for any text in the repo
map('n', '?S', '<cmd>Telescope live_grep<cr>', silentnoremap)
-- Pop open a window for finding and running commands by name
map('n', '?:', '<cmd>Telescope commands<cr>', silentnoremap)
-- Pop open a window for finding and running recent searches
map('n', '?H', '<cmd>Telescope search_history<cr>', silentnoremap)
-- Pop open a window for finding quickfix items
map('n', '?Q', '<cmd>Telescope quickfix<cr>', silentnoremap)
-- Pop open a window for finding references to the word under the cursor
map('n', '?R', '<cmd>Telescope lsp_references<cr>', silentnoremap)
-- Find any type in the workspace dynamically
map('n', '?T', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', silentnoremap)

-- Remind me of the above mappings
map('n', '??', ':echo "A Ag; F FZF; H Search history; Q quickfix; R references; S grep; T types; : commands"<CR>', { noremap = true })

-- Go to definition and pop back up
-- Don't do noremap to allow accessing LSP behaviour
map('n', '<right>', 'gd', { silent = true })
map('n', '<left>', '<c-t>', { silent = true })

-- Undo the unstaged Git hunk
map('n', '<leader>u', ':GitGutterUndoHunk<cr>', silentnoremap)

-- Read the code with focus on one section at the time.
map('n', '<leader>R', ':Twilight<cr>', silentnoremap)

-- More intuitive to me than ctrl+n and ctrl+p
map('i', '<c-j>', '<c-n>', silentnoremap)
map('i', '<c-k>', '<c-p>', silentnoremap)

-- Highlight the current word, and prepare to cycle through with n.
map('', '#', '<Plug>(asterisk-z*)zz', {silent=true})
map('', '*', '<Plug>(asterisk-z#)zz', {silent=true})

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz', silentnoremap)
map('n', 'N', 'Nzz', silentnoremap)

-- Intuitive increment and decrement
map('n', '+', '<c-a>', silentnoremap)
map('n', '-', '<c-x>', silentnoremap)

-- Conveniently enter command mode
map('n', ';', ':', {noremap=true})

-- Copy to the system clipboard
map('v', 'Y', '"*y', silentnoremap)

-- in/de-dent lines and remember the selection
map('v', '<', '<gv', silentnoremap)
map('v', '>', '>gv', silentnoremap)
map('v', 'H', '<gv', silentnoremap)
map('v', 'L', '>gv', silentnoremap)
map('n', '>', '>>', silentnoremap)
map('n', '<', '<<', silentnoremap)

-- Execute the last played macro
map('n', 'Q', '@@', silentnoremap)

-- Surround the current word with the following character
map('n', 'S', 'ysiw', {silent=true})

-- Move up and down wrapped lines intuitively, not literally
map('n', 'j', 'gj', silentnoremap)
map('n', 'k', 'gk', silentnoremap)

-- Easy access to normal mode from insert mode
map('i', 'jk', '<esc>', silentnoremap)

-- Quick-save the current buffer
map('n', 's', ':w<cr>', {noremap=true})

-- More easily switch window in the given direction
map('n', '<C-J>', '<C-W><C-J>', silentnoremap)
map('n', '<C-K>', '<C-W><C-K>', silentnoremap)
map('n', '<C-L>', '<C-W><C-L>', silentnoremap)
map('n', '<C-H>', '<C-W><C-H>', silentnoremap)

-- Super hacky plugin to shell out to github.com/kinbiko/kokodoko and fetch the
-- Github link to the current line(s)
-- Yes, that is an undo of the automatic replacing of text in the visual
-- mapping...
map('n', 'oiuy', ':!kokodoko % <C-R>=line(".")<CR><CR>', silentnoremap)
map('v', 'oiuy', [[:!kokodoko % <C-R>=line("'<")<CR>-<C-R>=line("'>")<CR><CR>u]], silentnoremap)

map('i', '<right>', '<c-x><c-o>', {noremap=true}) -- Open the completion menu

-- Close the quickfix window
map('n', '<c-c>', ':cclose<cr>', silentnoremap)

local mappings = {}
function mappings:registerLSPMappings(bufnr)
  local function bufmap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bufmap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', silentnoremap)
  bufmap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', silentnoremap)
  bufmap('n', '<leader>#',  '<cmd>lua vim.lsp.buf.references()<CR>', silentnoremap)
  bufmap('n', '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', silentnoremap)
  bufmap('n', '<leader>a',  '<cmd>lua vim.lsp.buf.code_action()<CR>', silentnoremap)
  bufmap('n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', silentnoremap)
  bufmap('n', '<leader>i',  '<cmd>Telescope lsp_implementations<cr>', silentnoremap)
  bufmap('n', '<leader>r',  '<cmd>lua vim.lsp.buf.rename()<CR>', silentnoremap)

  bufmap('i', '<c-p>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>', silentnoremap) -- Muscle-memory from IntelliJ
end

function mappings:registerGoMappings()
  map('n', '<leader>a', ':GoAlternate<cr>', silentnoremap)
  map('n', 'gi',        ':GoImports<cr>', silentnoremap)
  map('n', '<leader>l', ':GoMetaLinter<cr>', silentnoremap)
  map('n', '<leader>t', ':GoTest!<cr>', silentnoremap)
  map('n', '<leader>T', ':GoTestFunc!<cr>', silentnoremap)

  map('n', '<right>', ':GoDef<cr>', silentnoremap)
  map('n', '<left>', ':GoDefPop<cr>', silentnoremap)

  map('i', '<localleader><localleader><localleader>', '<esc>:GoFillStruct<cr>i', silentnoremap)
  map('i', '<localleader>=', ' := ', silentnoremap)
  map('i', 'nnn', '<esc>:GoIfErr<cr>', silentnoremap)
  map('i', 'testt', 'func Test(t *testing.T) {}<esc>16hi', silentnoremap)
  map('i', 'stt', 't.Run(tc.name, func(t *testing.T){})<left><left>', silentnoremap)
  map('i', 'ccc', 'context.Context', silentnoremap)
  map('i', 'cbb', 'context.Background()', silentnoremap)
  map('i', 'iii', 'interface{}', silentnoremap)
  map('i', 'sss', "'%s'", silentnoremap)
  map('i', 'ddd', '%d', silentnoremap)
  map('i', 'vvv', '%+v', silentnoremap)

end

function mappings:mapEmmet()
  map('i', 'hh', '<C-y>', { silent = true })
end

function mappings:mapNERDTree()
  map('n', ',,', ':NERDTreeToggle<cr>', silentnoremap) -- Open/close NERDTree
  map('n', '.<localleader>', ':NERDTreeFind<cr>', silentnoremap) -- Find the current file in NERDTree
end

return mappings
