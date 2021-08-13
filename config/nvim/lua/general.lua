local setg = vim.api.nvim_set_var

vim.cmd('colorscheme nord')

-- Setting this explicitly means I can copy Japanese to the clipboard without
-- mojibake
vim.cmd('lang en_US.UTF-8')

-- Ensure that I can enter markdown checkboxes without generating a double
-- space like this: [  ]. (should only have a single space inside when hitting
-- space)
setg('lexima_enable_space_rules', 0)
