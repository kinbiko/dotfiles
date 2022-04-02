require('kinbiko.mappings').mapNERDTree()

vim.g.NERDTreeMinimalUI = 1 -- Hide the "help" instructions that's shown at the top by default
vim.g.NERDTreeShowHidden = 1 -- Show hidden files (dotfiles)

-- Ignore these from showing up in NERDTree
vim.g.NERDTreeIgnore = { 'node_modules$', '.git$', '.DS_Store$', '.meta$', 'tags$', 'tags.lock$', 'tags.temp$', '.idea$', '\\.env$' }

-- Exit Vim if NERDTree is the only window remaining in the only tab.
-- Note: Copied directly from the NERDTree README.
-- TODO: address once I know how autocmd works in Lua
vim.api.nvim_command("autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
