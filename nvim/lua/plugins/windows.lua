return {
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.winminwidth = 0
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
}
