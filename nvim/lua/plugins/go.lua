return {
  {
    "fatih/vim-go",
    ft = { "go", "gomod" },
    keys = {
      { "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Add Struct Tags" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<leader>gt", "<cmd>GoTest<cr>", desc = "Run Tests" },
      { "<leader>ga", "<cmd>GoAlt<cr>", desc = "Open Alternative File" },
    },
  },
}
