return {
  {
    "fatih/vim-go",
    ft = { "go", "gomod" },
    lazy = true,
    keys = {
      { "<leader>gaf", "<cmd>GoAlt<cr>", desc = "Open Alternative File" },
      { "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Add Struct Tags" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill Struct" },
      { "<leader>gr", "<cmd>GoRename<cr>", desc = "Rename identifier under the cursor" },

      { "<leader>gtt", "<cmd>GoTest<cr>", desc = "Run tests in package" },
      { "<leader>gtr", "<cmd>GoTestFunc<cr>", desc = "Run closest test function" },
      { "<leader>gtf", "<cmd>GoTestFile<cr>", desc = "Run tests in current file" },

      { "<leader>gtcc", "<cmd>GoCoverageToggle<cr>", desc = "Toggle test coverage overlay" },
      { "<leader>gtcb", "<cmd>GoCoverageBrowser<cr>", desc = "Show test coverage in a browser" },

      { "<leader>gi", "<cmd>GoImports<cr>", desc = "Format and organize imports" },
      { "<leader>gp", "<cmd>GoPlay<cr>", desc = "Share snippet in go.play" },
      { "<leader>gw", "<cmd>GoDefStack<cr>", desc = "Where am I in the godef stack?" },

      { "<leader>gbt", "<cmd>GoBuildTags ", desc = "Add the given build tag(s) to various commands" },
    },
  },
}
