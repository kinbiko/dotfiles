return {
  {
    "jackMort/ChatGPT.nvim",
    enabled = os.getenv("OPENAI_API_KEY") ~= nil,
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
