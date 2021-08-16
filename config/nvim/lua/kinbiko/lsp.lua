local lc = require('lspconfig')
local li = require('lspinstall')
local m = require('kinbiko.mappings')

local on_attach = function(_, bufnr)
  m.registerLSPMappings(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('completion').on_attach()
end

-- == Lua (sumneko/lua-language-server) ==

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

-- == CSS (css-language-features) ==

local css_settings = {}

-- == Dockerfile (docker-langserver)==

local dockerfile_settings = {}

-- == Go (gopls)==

local go_settings = {}

-- == HTML (html-language-features)==

local html_settings = {}

-- == JSON (json-language-features)==

local json_settings = {}

-- == PHP (intelephense)==

local php_settings = {}

-- == Python (pyright-langserver)==

local python_settings = {}

-- == Ruby (solargraph)==

local ruby_settings = {}

-- == Rust (rust-analyzer)==

local rust_settings = {}

-- == TailwindCSS (tailwindcss-intellisense)==

local tailwindcss_settings = {}

-- == Terraform (terraform-ls)==

local terraform_settings = {}

-- == TypeScript (typescript-language-server)==

local typescript_settings = {}

-- == YAML (yaml-language-server)==

local yaml_settings = {}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities, -- enable snippet support
    on_attach = on_attach, -- map buffer local keybindings when the language server attaches
  }
end

-- lsp-install
local function setup_servers()
  li.setup()

  for _, server in pairs(li.installed_servers()) do
    local config = make_config()

    -- language specific config
    if server == "css" then config.settings = css_settings end
    if server == "dockerfile" then config.settings = dockerfile_settings end
    if server == "go" then config.settings = go_settings end
    if server == "html" then config.settings = html_settings end
    if server == "json" then config.settings = json_settings end
    if server == "lua" then config.settings = lua_settings end
    if server == "php" then config.settings = php_settings end
    if server == "python" then config.settings = python_settings end
    if server == "ruby" then config.settings = ruby_settings end
    if server == "rust" then config.settings = rust_settings end
    if server == "tailwindcss" then config.settings = tailwindcss_settings end
    if server == "terraform" then config.settings = terraform_settings end
    if server == "typescript" then config.settings = typescript_settings end
    if server == "yaml" then config.settings = yaml_settings end

    lc[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
li.post_install_hook = function ()
  -- setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

