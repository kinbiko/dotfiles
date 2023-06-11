-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

require("lazyvim.util").on_attach(function(_, buffer)
  -- create the autocmd to show diagnostics
  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("_auto_diag", { clear = true }),
    buffer = buffer,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end)
