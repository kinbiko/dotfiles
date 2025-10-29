return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately since it's used in init.lua
    priority = 1000, -- Load before other plugins
    opts = { style = "night", transparent = true },
  },
}
