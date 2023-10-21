return {
  {
    "ray-x/go.nvim", -- Go development features
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    keys = {
      { "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Add Struct Tags" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<leader>gt", "<cmd>GoTest<cr>", desc = "go test ./..." },
      { "<leader>ga", "<cmd>GoAlt<cr>", desc = "Open Alternative File" },
    },
  },
}
