return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        formatters_by_ft = {
          bash = { "shfmt" },
          go = { "goimports", "gci", "gofmt", "gofumpt", stop_after_first = true },
          javascript = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier" },
          proto = { "buf" },
          python = { "black" },
          yaml = { "prettier" },
        },
      })
    end,
  },
}
