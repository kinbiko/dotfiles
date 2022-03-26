local lsp_installer = require("nvim-lsp-installer")
local m = require('kinbiko.mappings')

-- Include the servers you want to have installed by default below
local servers = {
    "bashls",
    "eslint",
    "golangci_lint_ls",
    "gopls",
    "intelephense",
    "sumneko_lua",
    "tailwindcss",
    "terraformls",
    "tsserver",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    server:install()
  end
end


-- == Lua (sumneko/lua-language-server) ==

-- Configure lua language server for neovim development
local lua_settings = {
  settings = {
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
}

-- == Go (gopls)==

local go_settings = {
  on_attach = function(_, _)
    require("lsp_signature").on_attach()
  end
}

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    m.registerLSPMappings()
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = {}

    if server.name == "sumneko_lua" then
      opts = lua_settings
    end
    if server.name == "gopls" then
      opts = go_settings
    end

    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
