require("twilight").setup({
  dimming = {
    alpha = 0.25, -- amount of dimming
    inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 3 -- amount of lines we will try to show around the current line
})
