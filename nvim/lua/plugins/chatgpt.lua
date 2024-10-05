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
          max_tokens = 4096, -- default is 300
        },
      })

      local map = function(lhs, rhs)
        vim.keymap.set("n", lhs, rhs, { silent = true, remap = false })
        vim.keymap.set("v", lhs, rhs, { silent = true, remap = false })
      end

      map("<leader>ce", chatgpt.edit_with_instructions)
      map("<leader>co", chatgpt.openChat)
      map("<leader>cc", chatgpt.complete_code)
      map("<leader>ct", "<cmd>ChatGPTRun translate<CR>")
      map("<leader>cj", "<cmd>ChatGPTRun translate japanese<CR>")
      vim.keymap.set("i", "<C-l>", chatgpt.complete_code, { silent = true, remap = false })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
