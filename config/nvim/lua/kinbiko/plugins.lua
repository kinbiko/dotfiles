local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local function is_work_computer()
  return os.getenv('KINBIKO_ENV') == 'work'
end

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' } -- Packer can manage itself

  -- Editing
  use { 'cohama/lexima.vim' }     -- Automatically close [], '' etc. including def/end
  use { 'mattn/emmet-vim' }       -- Shortcuts for creating html/jsx boilerplate
  use { 'prettier/vim-prettier' } -- Prettier formatter
  use { 'tpope/vim-repeat' }      -- Make vim-surround things repeatable with .
  use { 'tpope/vim-surround' }    -- ysiw syntax for surrounding
  if not is_work_computer() then
    use { 'github/copilot.vim' }  -- AI code generator
  end

  -- Navigating
  vim.g.lightspeed_no_default_keymaps = 1 -- Stop lightspeed from adding (f/t/s) default mappings. Must be set before loading.
  use { 'ggandor/lightspeed.nvim' } -- Accurate navigation ala vimium.
  use {
    'google/executor.nvim',
    requires = { 'MunifTanjim/nui.nvim' }
  }
  use { 'christoomey/vim-tmux-navigator' } -- Work better with tmux.
  use { 'haya14busa/vim-asterisk' }        -- Use * without moving immediately
  use { 'nacro90/numb.nvim' }              -- Preview the line while typing :<number>

  use {
    'kyazdani42/nvim-tree.lua', -- File tree, powerful and fast.
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }
  use {
    'nvim-telescope/telescope.nvim', -- Floating window of various search results.
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency.
      'nvim-treesitter/nvim-treesitter' -- Optional dependency.
    }
  }

  -- Style
  use { 'folke/tokyonight.nvim' }         -- TokyoNight theme
  use { 'folke/twilight.nvim' }           -- "reading" mode that disables distant syntax highlighting
  use { 'machakann/vim-highlightedyank' } -- Highlight when yanking so you don't need to pop into visual mode constantly
  use {
    'nvim-lualine/lualine.nvim', -- Pretty status bar
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use {
    'echasnovski/mini.nvim'
  }

  -- Autocomplete and snippets
  use {
  'VonHeikemen/lsp-zero.nvim',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},

    -- Snippets
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  }
}
  -- Language support
  use { 'elzr/vim-json' }               -- JSON syntax (error) highlighting + concealment
  use { 'evanleck/vim-svelte' }         -- Better support for Svelte
  use { 'hashivim/vim-terraform' }      -- Terraform syntax highlighting etc.
  use { 'leafgarland/typescript-vim' }  -- Typescript syntax highlighting
  use { 'maxmellon/vim-jsx-pretty' }    -- Make JSX look good (technically this supports TSX too, but has perf issues)
  use { 'pangloss/vim-javascript' }     -- Syntax highlighting and concealment for JavaScript
  use { 'peitalin/vim-jsx-typescript' } -- TSX syntax highlighting without the perf issues
  use { 'jjo/vim-cue' }                 -- CUE syntax highlighting
  use {
    'fatih/vim-go', -- Make vim good with Go
    run = ':GoUpdateBinaries',
  }

  -- Git
  use { 'rhysd/git-messenger.vim' } -- Show the commit message for the current line.
  use { 'rhysd/committia.vim' }     -- Running 'git commit' on the command line enables diff and other niceties. ⚡ 2022-09-25. Does not work well with --amend
  use { 'tpope/vim-fugitive' }      -- Most git features available through :Git foo

  if packer_bootstrap then
    require('packer').sync()
  end
end)
