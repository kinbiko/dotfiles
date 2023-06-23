return {
  {
    "ray-x/go.nvim", -- Go development features
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    keys = {
      { "<leader>GAT", "<cmd>GoAddTag<cr>", desc = "Add Struct Tags" },
      { "<leader>GFS", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<leader>GT", "<cmd>GoTest<cr>", desc = "go test ./..." },
      { "<leader>GA", "<cmd>GoAlt<cr>", desc = "Open Alternative File" },
      { "<leader>GE", "<cmd>GoIfErr<cr>", desc = "Open Alternative File" },
      { "<leader>GR", "<cmd>GoGenReturn<cr>", desc = "Open Alternative File" },
    },
  },
}
