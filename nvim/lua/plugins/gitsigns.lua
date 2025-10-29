return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "新" },
        change = { text = "∂" },
        delete = { text = "消" }, -- the line below has been deleted
        topdelete = { text = "‾" }, -- something has been deleted from the top of the file
        changedelete = { text = "▎" },
        untracked = { text = "?" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")
        vim.keymap.set("n", "<leader>gu", gs.reset_hunk, { buffer = buffer, desc = "Undo hunk" })
        vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = buffer, desc = "Git Blame" })
      end,
    },
  },
}
