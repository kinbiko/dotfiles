local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true, remap = false }
  vim.keymap.set(mode, lhs, rhs, opts)
end

return {
  {
    "monaqa/dial.nvim", -- Better increments e.g. for semver and dates
    config = function()
      -- Intuitive increment and decrement
      map("n", "+", require("dial.map").inc_normal(), { noremap = true })
      map("n", "-", require("dial.map").dec_normal(), { noremap = true })
      map("n", "g+", require("dial.map").inc_gnormal(), { noremap = true })
      map("n", "g-", require("dial.map").dec_gnormal(), { noremap = true })
      map("v", "+", require("dial.map").inc_visual(), { noremap = true })
      map("v", "-", require("dial.map").dec_visual(), { noremap = true })
      map("v", "g+", require("dial.map").inc_gvisual(), { noremap = true })
      map("v", "g-", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
}
