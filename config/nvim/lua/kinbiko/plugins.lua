-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

local function is_work_computer()
  return os.getenv('KINBIKO_ENV') == 'work'
end


require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', commit='6afb67460283f0e990d35d229fd38fdc04063e0a'} -- ❓ 2022-09-18. Packer can manage itself

  -- Editing
  use { 'cohama/lexima.vim', commit='42d0caf3ff2a32116f277482e3504bb29f9e5cc2' }     -- Automatically close [], '' etc. including def/end
  use { 'mattn/emmet-vim', commit='def5d57a1ae5afb1b96ebe83c4652d1c03640f4d' }       -- Shortcuts for creating html/jsx boilerplate
  use { 'prettier/vim-prettier', commit='5e6cca21e12587c02e32a06bf423519eb1e9f1b2' } -- Prettier formatter
  use { 'tpope/vim-repeat', commit='24afe922e6a05891756ecf331f39a1f6743d3d5a' }      -- Make vim-surround things repeatable with .
  use { 'tpope/vim-surround', commit='bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea' }    -- ysiw syntax for surrounding
  if not is_work_computer() then
    use { 'github/copilot.vim', commit='af9da6457790b651871b687b8f47d130cde083fc' }  -- AI code generator
  end

  -- Navigating
  vim.g.lightspeed_no_default_keymaps = 1 -- Stop lightspeed from adding (f/t/s) default mappings. Must be set before loading.
  use { 'ggandor/lightspeed.nvim', commit='a5b79ddbd755ac8d21a8704c370b5f643dda94aa' } -- Accurate navigation ala vimium.

  use { 'christoomey/vim-tmux-navigator', commit='afb45a55b452b9238159047ce7c6e161bd4a9907' } -- Work better with tmux.
  use { 'haya14busa/vim-asterisk', commit='77e97061d6691637a034258cc415d98670698459' }        -- Use * without moving immediately
  use { 'nacro90/numb.nvim', commit='453c50ab921fa066fb073d2fd0f826cb036eaf7b' }              -- Preview the line while typing :<number>

  use {
    'kyazdani42/nvim-tree.lua', -- File tree, powerful and fast.
    commit='52b0c3215271349ed91421b9bb39d61b58d9e5d4',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }
  use {
    'nvim-telescope/telescope.nvim', -- Floating window of various search results.
    commit='30e2dc5232d0dd63709ef8b44a5d6184005e8602',
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency.
      'nvim-treesitter/nvim-treesitter' -- Optional dependency.
    }
  }

  -- Style
  use { 'folke/tokyonight.nvim', commit='81f0db1bd0b7f4eb8eb9e81c4b4f12b878cefb10' }         -- TokyoNight theme
  use { 'folke/twilight.nvim', commit='1ffa6a4d89fb2fbb784c6674044bf54f1fca936f' }           -- "reading" mode that disables distant syntax highlighting
  use { 'machakann/vim-highlightedyank', commit='f9db473137ca96c6a989ec3e2b7edf8a3189c448' } -- Highlight when yanking so you don't need to pop into visual mode constantly
  use {
    'nvim-lualine/lualine.nvim', -- Pretty status bar
    commit='a52f078026b27694d2290e34efa61a6e4a690621',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- Autocomplete and snippets
  use { 'L3MON4D3/LuaSnip', commit='d36c063b7f6e701852f7880f1314656592a61b4f' }         -- Snippet framework.
  use { 'hrsh7th/nvim-cmp', commit='17a55b3d5498c617855d015bbcad0c872d10c879' }         -- Completion framework, supports many kinds of completion, to be installed separately.
  use { 'hrsh7th/cmp-nvim-lsp', commit='affe808a5c56b71630f17aa7c38e15c59fd648a8' }     -- Set up completion based on LSP information.
  use { 'saadparwaiz1/cmp_luasnip', commit='a9de941bcbda508d0a45d28ae366bb3f08db2e36' } -- Set up completion based on snippet framework.

  -- Language support
  use { 'elzr/vim-json', commit='3727f089410e23ae113be6222e8a08dd2613ecf2' }               -- JSON syntax (error) highlighting + concealment
  use { 'evanleck/vim-svelte', commit='1080030d6a1bc6582389c133a07552ba0a442410' }         -- Better support for Svelte
  use { 'hashivim/vim-terraform', commit='f0b17ac9f1bbdf3a29dba8b17ab429b1eed5d443' }      -- Terraform syntax highlighting etc.
  use { 'leafgarland/typescript-vim', commit='52f3ca3474d51f5021696ffb7297d989e49121ac' }  -- Typescript syntax highlighting
  use { 'maxmellon/vim-jsx-pretty', commit='6989f1663cc03d7da72b5ef1c03f87e6ddb70b41' }    -- Make JSX look good (technically this supports TSX too, but has perf issues)
  use { 'pangloss/vim-javascript', commit='c470ce1399a544fe587eab950f571c83cccfbbdc' }     -- Syntax highlighting and concealment for JavaScript
  use { 'peitalin/vim-jsx-typescript', commit='22df470d92651426f2377e3166488672f7b4b4ef' } -- TSX syntax highlighting without the perf issues
  use { 'jjo/vim-cue', commit='bd1a62303d096aa24fe4160a475645087f8770b3' }                 -- CUE syntax highlighting
  use {
    'fatih/vim-go', -- Make vim good with Go
    commit='22b2273cfe562ac1c1af976ce77f18a3b1776f3c',
    run = ':GoUpdateBinaries',
  }

  -- LSP
  use { 'ray-x/lsp_signature.nvim' }        -- ❓ 2022-09-18. Keep the function signature docs up while filling in params
  use { 'williamboman/nvim-lsp-installer' } -- ❓ 2022-09-18. Install LSP servers on demand with LSPInstall
  use { 'neovim/nvim-lspconfig' }           -- ❓ 2022-09-18. "Easy" LSP configuration

  -- Git
  use { 'rhysd/git-messenger.vim', commit='8a61bdfa351d4df9a9118ee1d3f45edbed617072' } -- Show the commit message for the current line.
  use { 'rhysd/committia.vim', commit='0b4df1a7f48ffbc23b009bd14d58ee1be541917c' }     -- Running 'git commit' on the command line enables diff and other niceties. ⚡ 2022-09-25. Does not work well with --amend
  use { 'tpope/vim-fugitive', commit='dd8107cabf5fe85df94d5eedcae52415e543f208' }      -- Most git features available through :Git foo
end)
