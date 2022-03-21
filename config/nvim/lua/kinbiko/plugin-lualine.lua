require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'branch', 'diff', 'diagnostics'},
    lualine_b = {},
    lualine_c = {'filename', 'filetype'},
    lualine_x = {'progress'},
    lualine_y = {'location'},
    lualine_z = {'mode'}
  }
}

