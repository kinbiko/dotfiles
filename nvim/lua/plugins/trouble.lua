return {
  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>xt", "<cmd>Trouble todo<cr>", desc = "TODOs" },
    },
  },
}
