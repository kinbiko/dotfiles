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
  use 'rust-lang/rust.vim' --  Official Rust plugin.
  use 'hashivim/vim-terraform' --  Terraform support
  use 'ryanoasis/vim-devicons' -- Pretty icons per filetype. Must be loaded last.
  use 'pangloss/vim-javascript' -- Syntax highlighting and concealment for JavaScript
  use 'maxmellon/vim-jsx-pretty' --  Make JSX look good (technically this supports TSX too, but has perf issues)
  use 'leafgarland/typescript-vim' -- Typescript syntax highlighting
  use 'peitalin/vim-jsx-typescript' -- TSX syntax highlighting without the perf issues

 -- Shortcuts for creating html/jsx boilerplate
  use {
    'mattn/emmet-vim',
    ft = { 'javascript', 'html', 'xml', 'jsx', 'markdown', 'typescript' },
    cmd = 'EmmetInstall'
  }

  -- Prettier formatter
  use {
    'prettier/vim-prettier',
    ft = {'javascript', 'json', 'css', 'markdown', 'md', 'typescript', 'typescriptreact'}
  }

  -- JSON syntax (error) highlighting + concealment
  use {
    'elzr/vim-json',
    ft = {'javascript', 'json' }
  }

end)

