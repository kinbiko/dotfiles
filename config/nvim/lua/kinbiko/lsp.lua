local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    "bashls",
    "eslint",
    -- "golangci_lint_ls", -- this has *serious* performance issues
    "gopls",
    "intelephense",
    "sumneko_lua",
    "tailwindcss",
    "terraformls",
    "tsserver",
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({mapping = cmp_mappings})
lsp.nvim_workspace()

lsp.setup()

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false, silent = true}
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', '<right>', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)
