local map = function(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

-- Keys I rarely use in normal mode (OK to overwrite):
-- t E K L M X Y Z [ ] \ | <left> <right>

map('n', '0', '^', {noremap=true, silent=true}) -- Make 0 take me to the first non-blank character of the line.
