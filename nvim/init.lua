-- The order of these files matters
require("options")
require("setup-plugins")
require("autocmds")
require("keyboard-bindings-mappings") -- a longer name makes it easier to find with Telescope

local function set_colorscheme()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a") -- NOTE: result is empty unless dark.
  handle:close()

  local theme = (result:match("Dark") and "tokyonight-night") or "tokyonight-day"
  vim.cmd.colorscheme(theme)
end

set_colorscheme()
vim.api.nvim_create_autocmd("FocusGained", { pattern = "*", callback = set_colorscheme })
