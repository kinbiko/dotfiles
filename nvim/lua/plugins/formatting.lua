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
          bash = { "beautysh", "shfmt" },
          cue = { "cueimports" },
          go = { { "gci", "goimports", "gofmt", "gofumpt" }, "gomodifytags" },
          javascript = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          lua = { "stylua" },
          markdown = { { "prettierd", "prettier" }, "cbfmt", "markdownlint", "remark" },
          proto = { "buf" },
          python = { "isort", "black" },
          rubyfmt = { "rubyfmt" },
          sql = { { "sql-formatter", "sqlfmt" } },
          yaml = { { "prettierd", "prettier" } },
          zsh = { "beautysh" },
        },
      })
    end,
  },
}
