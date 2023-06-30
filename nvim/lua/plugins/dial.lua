return {
  {
    "monaqa/dial.nvim", -- Better increments e.g. for semver and dates
    config = function()
      local dial = require("dial.map")
      -- Intuitive increment and decrement
      vim.keymap.set("n", "+", dial.inc_normal(), { silent = true })
      vim.keymap.set("n", "-", dial.dec_normal(), { silent = true })
      vim.keymap.set("n", "g+", dial.inc_gnormal(), { silent = true })
      vim.keymap.set("n", "g-", dial.dec_gnormal(), { silent = true })
      vim.keymap.set("v", "+", dial.inc_visual(), { silent = true })
      vim.keymap.set("v", "-", dial.dec_visual(), { silent = true })
      vim.keymap.set("v", "g+", dial.inc_gvisual(), { silent = true })
      vim.keymap.set("v", "g-", dial.dec_gvisual(), { silent = true })
    end,
  },
}
