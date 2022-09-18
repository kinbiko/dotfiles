-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

-- Legend:
-- ✅ means that the plugin works well, docs have been read, and is fully utilized.
-- ⚡ means there's an issue with this plugin.
-- ❓ means that the plugin has not been fully understood yet (not read docs),
--    and that its features might not be properly utilized

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- ❓ 2022-09-18. Packer can manage itself

  -- Editing
  use 'cohama/lexima.vim'     -- ✅ 2022-09-18. Automatically close [], '' etc. including def/end
  use 'mattn/emmet-vim'       -- ❓ 2022-09-18. Shortcuts for creating html/jsx boilerplate
  use 'prettier/vim-prettier' -- ❓ 2022-09-18. Prettier formatter
  use 'tpope/vim-repeat'      -- ❓ 2022-09-18. Make vim-surround things repeatable with .
  use 'tpope/vim-surround'    -- ❓ 2022-09-18. ysiw syntax for surrounding
  use 'sickill/vim-pasta'     -- ❓ 2022-09-18. Context aware pasting + indentation

  -- Navigating
  vim.g.lightspeed_no_default_keymaps = 1 -- Stop lightspeed from adding (f/t/s) default mappings
  use 'ggandor/lightspeed.nvim'        -- ❓ 2022-09-18. Accurate navigation ala vimium
  use 'christoomey/vim-tmux-navigator' -- ✅ 2022-09-18. Work better with tmux.
  use 'haya14busa/vim-asterisk'        -- ❓ 2022-09-18. Use * without moving immediately
  use 'junegunn/fzf.vim'               -- ❓ 2022-09-18. The lightning fast fzf fuzzy finder
  use 'nacro90/numb.nvim'              -- ❓ 2022-09-18. Preview the line while typing :<number>
  use {
    'kyazdani42/nvim-tree.lua', -- ✅ 2022-09-18.
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }
  use {
    'nvim-telescope/telescope.nvim', -- ❓ 2022-09-18. Floating window of various search results.
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency.
      'nvim-treesitter/nvim-treesitter' -- Optional dependency.
    }
  }

  -- Style
  use 'folke/tokyonight.nvim'         -- ✅ 2022-09-18. TokyoNight theme
  use 'folke/twilight.nvim'           -- ❓ 2022-09-18. "reading" mode that disables distant syntax highlighting
  use 'machakann/vim-highlightedyank' -- ❓ 2022-09-18. Highlight when yanking so you don't need to pop into visual mode constantly
  use {
    'nvim-lualine/lualine.nvim', -- ❓ 2022-09-18. Pretty status bar
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- Autocomplete and snippets
  use 'L3MON4D3/LuaSnip'         -- ❓ 2022-09-18.
  use 'hrsh7th/cmp-buffer'       -- ❓ 2022-09-18.
  use 'hrsh7th/cmp-cmdline'      -- ❓ 2022-09-18.
  use 'hrsh7th/cmp-nvim-lsp'     -- ❓ 2022-09-18.
  use 'hrsh7th/cmp-path'         -- ❓ 2022-09-18.
  use 'hrsh7th/nvim-cmp'         -- ❓ 2022-09-18.
  use 'saadparwaiz1/cmp_luasnip' -- ❓ 2022-09-18.
  use 'folke/which-key.nvim'     -- ❓ 2022-09-18. Reminders of which key-bindings are available if getting stuck half-way through a binding

  -- Language support
  use 'elzr/vim-json'               -- ❓ 2022-09-18. JSON syntax (error) highlighting + concealment
  use 'evanleck/vim-svelte'         -- ❓ 2022-09-18. Better support for Svelte
  use 'hashivim/vim-terraform'      -- ❓ 2022-09-18. Terraform syntax highlighting etc.
  use 'leafgarland/typescript-vim'  -- ❓ 2022-09-18. Typescript syntax highlighting
  use 'maxmellon/vim-jsx-pretty'    -- ❓ 2022-09-18. Make JSX look good (technically this supports TSX too, but has perf issues)
  use 'pangloss/vim-javascript'     -- ❓ 2022-09-18. Syntax highlighting and concealment for JavaScript
  use 'peitalin/vim-jsx-typescript' -- ❓ 2022-09-18. TSX syntax highlighting without the perf issues
  use {
    'fatih/vim-go', -- ❓ 2022-09-18. Make vim good with Go
    run = ':GoUpdateBinaries',
  }

  -- LSP
  use 'ray-x/lsp_signature.nvim'        -- ❓ 2022-09-18. Keep the function signature docs up while filling in params
  use 'williamboman/nvim-lsp-installer' -- ❓ 2022-09-18. Install LSP servers on demand with LSPInstall
  use 'neovim/nvim-lspconfig'           -- ❓ 2022-09-18. "Easy" LSP configuration

  -- Git
  use 'rhysd/committia.vim' -- ❓ 2022-09-18. Running 'git commit' on the command line enables diff and other niceties
  use 'tpope/vim-fugitive'  -- ❓ 2022-09-18. Most git features available through :Git foo

end)
