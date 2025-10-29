return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      return os.getenv("ANTHROPIC_API_KEY") ~= nil
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
        },
        adapters = {
          http = {
            anthropic = function()
              return require("codecompanion.adapters").extend("anthropic", {
                env = {
                  api_key = "ANTHROPIC_API_KEY",
                },
                schema = {
                  model = {
                    default = "claude-sonnet-4-20250514",
                  },
                },
              })
            end,
          },
        },
      })

      -- Keybindings similar to your old ChatGPT setup
      local map = function(modes, lhs, rhs, desc)
        vim.keymap.set(modes, lhs, rhs, { silent = true, desc = desc })
      end

      -- Chat and inline editing
      map({ "n", "v" }, "<leader>co", "<cmd>CodeCompanionChat Toggle<cr>", "Toggle Chat")
      map({ "n", "v" }, "<leader>ce", "<cmd>CodeCompanionActions<cr>", "Actions (edit/explain/etc)")
      map("v", "<leader>ca", "<cmd>CodeCompanionAdd<cr>", "Add selection to chat")

      -- Quick actions
      map("n", "<leader>cc", "<cmd>CodeCompanion<cr>", "Inline prompt")
      map("v", "<leader>cc", "<cmd>CodeCompanion<cr>", "Inline prompt with selection")
    end,
  },
}
