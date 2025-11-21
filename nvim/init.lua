-- The order of these files matters
require("options")
require("setup-plugins")
require("autocmds")
require("keyboard-bindings-mappings") -- a longer name makes it easier to find with Telescope
vim.cmd.colorscheme("tokyonight-night")

-- Setup japanese dictionary (registers :JaDict command and preloads dictionary)
require("japanese-dict").setup()
