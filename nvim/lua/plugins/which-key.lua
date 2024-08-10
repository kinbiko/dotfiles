return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        mode = { "n", "v" },
        { "<leader>G", group = "Go" },
        { "<leader>da", group = "adapters" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "g", group = "goto" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "search" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>t", group = "test" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
      })
    end,
  },
}
