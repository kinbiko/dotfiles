return {
  {
    "nathom/tmux.nvim",
    lazy = false, -- Load immediately so keybindings work
    cond = function()
      return vim.env.TMUX ~= nil -- Only load if we're in tmux
    end,
    -- Note: tmux.nvim doesn't have a setup() function, it works directly via require
    -- The plugin provides the move_left/right/up/down functions we use in keybindings
  },
}
