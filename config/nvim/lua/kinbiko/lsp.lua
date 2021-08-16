local lc = require('lspconfig')
local li = require('lspinstall')
local m = require('kinbiko.mappings')

-- Notes from kabouzeid/nvim-lspinstall:
-- css - css-language-features
-- dockerfile - docker-langserver
-- go - gopls
-- html - html-language-features
-- json - json-language-features
-- lua - sumneko/lua-language-server
-- php - intelephense
-- python - pyright-langserver
-- ruby - solargraph
-- rust - rust-analyzer
-- tailwindcss - tailwindcss-intellisense
-- terraform - terraform-ls
-- typescript - typescript-language-server
-- yaml - yaml-language-server

local on_attach = function(_, bufnr)
  m.registerLSPMappings(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('completion').on_attach()
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT', -- LuaJIT in the case of Neovim
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      globals = {'vim'}, -- Get the language server to recognize the `vim` global
    },
    workspace = { -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  li.setup()

  for _, server in pairs(li.installed_servers()) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end

    lc[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
li.post_install_hook = function ()
  -- setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

