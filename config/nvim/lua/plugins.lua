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

  use { 'prettier/vim-prettier', ft = cat(web_fts, {'markdown', 'md' }) } -- Prettier formatter
  use { 'elzr/vim-json', ft = {'javascript', 'json' } } -- JSON syntax (error) highlighting + concealment
  use { 'rust-lang/rust.vim', ft='rust' } --  Official Rust plugin.
  use { 'hashivim/vim-terraform', ft='hcl' } --  Terraform support
  use { 'pangloss/vim-javascript', ft=web_fts } -- Syntax highlighting and concealment for JavaScript
  use { 'maxmellon/vim-jsx-pretty', ft=web_fts } --  Make JSX look good (technically this supports TSX too, but has perf issues)
  use { 'leafgarland/typescript-vim', ft=web_fts } -- Typescript syntax highlighting
  use { 'peitalin/vim-jsx-typescript', ft=web_fts } -- TSX syntax highlighting without the perf issues

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
    ft = {'go'},
    run = ':GoUpdateBinaries'
  }

  -- LSP
  -- TODO: Replace with built-in LSP
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

end)

