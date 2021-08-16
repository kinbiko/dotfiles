-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'arcticicestudio/nord-vim' -- Nord theme
  use 'folke/tokyonight.nvim' -- TokyoNight theme
  use 'preservim/nerdtree' -- File tree on the left hand side

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

  local web_fts = { 'css', 'html', 'javascript', 'json', 'jsx', 'typescript', 'typescriptreact' }

  local cat = function(t1, t2)
    local ret = {}
    for _,v in ipairs(t1) do table.insert(ret, v) end
    for _,v in ipairs(t2) do table.insert(ret, v) end
    return ret
  end

 -- Shortcuts for creating html/jsx boilerplate
  use {
    'mattn/emmet-vim',
    ft = cat(web_fts, { 'xml', 'markdown', 'md' }),
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

  -- Install the fzf binary as well
  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end
  }

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

  -- TODO: Check these plugins out when
  -- https://github.com/ms-jpq/coq_nvim/issues/11 has been resolved.
  -- use { 'ms-jpq/coq_nvim', branch='coq' }
  -- use { 'ms-jpq/coq.artifacts', branch='artifacts' }
  -- use { 'ms-jpq/chadtree', branch='chad', run = 'python3 -m chadtree deps'}
end)

