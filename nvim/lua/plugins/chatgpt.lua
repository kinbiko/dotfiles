return {
  {
    "jackMort/ChatGPT.nvim",
    cond = os.getenv("OPENAI_API_KEY") ~= nil,
    event = "VeryLazy",
    config = function()
      local chatgpt = require("chatgpt")
      chatgpt.setup({
        popup_layout = {
          center = {
            width = "90%",
            height = "80%",
          },
        },
        edit_with_instructions = {
          diff = true,
        },
        openai_params = {
          max_tokens = 4095, -- default is 300
        },
      })
      require("which-key").add({
        mode = { "v", "n" },
        {
          "<leader>ce",
          function()
            chatgpt.edit_with_instructions()
          end,
          desc = "Tell ChatGPT to edit the code",
        },
        {
          "<leader>co",
          function()
            chatgpt.openChat()
          end,
          desc = "Normal ChatGPT",
        },
        {
          "<leader>cc",
          function()
            chatgpt.complete_code()
          end,
          desc = "Complete code",
        },
        {
          "<leader>ct",
          "<cmd>ChatGPTRun translate<CR>",
          desc = "Translate to English",
        },
        {
          "<leader>cj",
          "<cmd>ChatGPTRun translate japanese<CR>",
          desc = "Translate to Japanese",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
