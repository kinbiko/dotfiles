-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use 'preservim/nerdtree' -- File tree on the left hand side
end)

