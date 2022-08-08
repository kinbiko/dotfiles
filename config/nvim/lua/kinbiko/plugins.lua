-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'L3MON4D3/LuaSnip'
  use 'christoomey/vim-tmux-navigator' -- Work better with tmux
  use 'cohama/lexima.vim' -- Automatically close [], '' etc. including def/end
  use 'elzr/vim-json' -- JSON syntax (error) highlighting + concealment
  use 'evanleck/vim-svelte' -- Better support for Svelte
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' } -- Make vim good with Go
  use 'folke/tokyonight.nvim' -- TokyoNight theme
  use 'folke/twilight.nvim' -- "reading" mode that disables distant syntax highlighting
  use 'folke/which-key.nvim' -- Reminders of which key-bindings are available if getting stuck half-way through a binding
  use 'hashivim/vim-terraform' -- Terraform syntax highlighting etc.
  use 'haya14busa/vim-asterisk' -- Use * without moving immediately
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  -- Disabling the mappings that the following plugin will add (f/F/t/T/s/S)
  -- before sourcing the plugin
  vim.g.lightspeed_no_default_keymaps = 1
  use 'ggandor/lightspeed.nvim' -- Accurate navigation ala vimium
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] } -- Install the fzf binary
  use 'junegunn/fzf.vim' -- The lightning fast fzf fuzzy finder
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use 'leafgarland/typescript-vim' -- Typescript syntax highlighting
  use 'machakann/vim-highlightedyank' -- Highlight when yanking so you don't need to pop into visual mode constantly
  use 'mattn/emmet-vim' -- Shortcuts for creating html/jsx boilerplate
  use 'maxmellon/vim-jsx-pretty' --  Make JSX look good (technically this supports TSX too, but has perf issues)
  use 'nacro90/numb.nvim' -- Preview the line while typing :<number>
  use 'neovim/nvim-lspconfig' -- Easy LSP configuration
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency.
      'nvim-treesitter/nvim-treesitter' -- Optional dependency.
    }
  }
  use 'pangloss/vim-javascript'-- Syntax highlighting and concealment for JavaScript
  use 'peitalin/vim-jsx-typescript' -- TSX syntax highlighting without the perf issues
  use 'prettier/vim-prettier' -- Prettier formatter
  use 'ray-x/lsp_signature.nvim' -- Keep the function signature docs up while filling in params
  use 'rhysd/committia.vim' -- Running 'git commit' on the command line enables diff and other niceties
  use 'saadparwaiz1/cmp_luasnip'
  use 'sickill/vim-pasta' -- Context aware pasting + indentation
  use 'stevearc/stickybuf.nvim' -- Make NERDTree stay NERDTree, even when I'm stupid.
  use 'tpope/vim-fugitive' -- Most git features available through :Git foo
  use 'tpope/vim-repeat' -- Make vim-surround things repeatable with .
  use 'tpope/vim-surround' -- ysiw syntax for surrounding
  use 'williamboman/nvim-lsp-installer' -- Install LSP servers on demand with LSPInstall

end)
