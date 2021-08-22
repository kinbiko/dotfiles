-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'arcticicestudio/nord-vim' -- Nord theme
  use 'folke/tokyonight.nvim' -- TokyoNight theme
  use 'preservim/nerdtree' -- File tree on the left hand side
  use 'stevearc/stickybuf.nvim' -- Make NERDTree stay NERDTree, even when I'm stupid.
  use 'bronson/vim-trailing-whitespace' -- Mark trailing whitespace
  use 'easymotion/vim-easymotion' -- Accurate navigation ala vimium
  use 'haya14busa/vim-asterisk' -- Use * without moving immediately
  use 'junegunn/fzf.vim' -- The lightning fast fzf fuzzy finder
  use 'airblade/vim-gitgutter' -- Makes the git gutter with +, ~, and - available
  use 'tpope/vim-fugitive' -- Most git features available through :G*
  use 'rhysd/committia.vim' -- Running 'git commit' on the command line enables diff and other niceties
  use 'tpope/vim-surround' -- ysiw syntax for surrounding
  use 'tpope/vim-repeat' -- Make vim-surround things repeatable with .
  use 'cohama/lexima.vim' -- Automatically close [], '' etc. including def/end
  use 'christoomey/vim-tmux-navigator' -- Work better with tmux
  use 'machakann/vim-highlightedyank' -- Highlight when yanking so you don't need to pop into visual mode constantly
  use 'sickill/vim-pasta' -- Context aware pasting + indentation
  use 'ryanoasis/vim-devicons' -- Pretty icons per filetype. Must be loaded after NERDTree.
  use 'folke/twilight.nvim' -- "reading" mode that disables distant syntax highlighting
  use 'mhinz/vim-startify' -- Pretty start screen
  use 'nacro90/numb.nvim' -- Preview the line while typing :<number>

 -- Shortcuts for creating html/jsx boilerplate
  use {
    'mattn/emmet-vim',
    ft = { 'css', 'html', 'javascript', 'json', 'typescript', 'typescriptreact', 'markdown' },
    cmd = 'EmmetInstall'
  }

  use 'prettier/vim-prettier' -- Prettier formatter
  use 'elzr/vim-json' -- JSON syntax (error) highlighting + concealment
  use 'rust-lang/rust.vim'--  Official Rust plugin.
  use 'hashivim/vim-terraform' --  Terraform support
  use 'pangloss/vim-javascript'-- Syntax highlighting and concealment for JavaScript
  use 'maxmellon/vim-jsx-pretty' --  Make JSX look good (technically this supports TSX too, but has perf issues)
  use 'leafgarland/typescript-vim' -- Typescript syntax highlighting
  use 'peitalin/vim-jsx-typescript' -- TSX syntax highlighting without the perf issues

  use { 'junegunn/fzf', run = vim.fn['fzf#install'] } -- Install the fzf binary as well

  -- Make vim good with Go
  use {
    'fatih/vim-go',
    run = ':GoUpdateBinaries'
  }
  use 'neovim/nvim-lspconfig' -- Easy LSP configuration
  use 'kabouzeid/nvim-lspinstall' -- Install LSP servers on demand with LSPInstall

  -- This is a bit excessive: Only importing to avoid having documentation show
  -- up in a nofile buffer (instead of a quickfix window) that I have to close
  -- after each completion. If I could figure out how to make this window a
  -- floating window or a quickfix window then I might not care about this
  -- particular plugin
  use 'nvim-lua/completion-nvim'


  -- This is a big fat plugin that I'm really only using to make autocompletion useful.
  use { 'ms-jpq/coq_nvim', branch='coq' }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end
  }


  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency.
      'nvim-treesitter/nvim-treesitter' -- Optional dependency.
    }
  }

  -- LSP powered code skimming tool. Requires some TLC to get it working well.
  -- use 'stevearc/aerial.nvim'

  -- Easymotion on speed. Takes some cgetting used to and mapping is awkward.
  -- use 'ggandor/lightspeed.nvim'

  -- This plugin is really nice, but it doesn't play nicely with NERDTree,
  -- easymotion, and other plugins (false-positive dimming of active windows)
  -- use 'sunjon/shade.nvim' -- Dim the non-active windows

end)
