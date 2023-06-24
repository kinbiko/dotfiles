local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local function is_work_computer()
  return os.getenv("KINBIKO_ENV") == "work"
end

require("lazy").setup({
  spec = {
    -- LazyVim native plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { colorscheme = "tokyonight-night" } },
    { import = "lazyvim.plugins.extras.coding.copilot", enabled = not is_work_computer() },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- show hex colors in css and js etc.

    -- Disable some plugins that LazyVim adds by default
    { "mini.surround", enabled = false },
    { "ggandor/leap.nvim", enabled = false },
    { "ggandor/flit.nvim", enabled = false },
    { "akinsho/bufferline.nvim", enabled = false },
    { "lukas-reineke/indent-blankline.nvim", enabled = false },
    { "goolord/alpha-nvim", enabled = false }, -- Splashscreen. More distracting than useful.
    { "nvim-neo-tree/neo-tree.nvim", enabled = false }, -- A decent tree browser, but I prefer nvim-tree

    -- Add other plugins that I want
    { "haya14busa/vim-asterisk" }, -- Make * and # stay on the first element before iterating
    { "kyazdani42/nvim-tree.lua" }, -- Tree based navigator
    { "monaqa/dial.nvim" }, -- Better increments e.g. for semver and dates
    { "nathom/tmux.nvim" }, -- Move smoothly between vim and tmux winows
    { "tpope/vim-repeat" }, -- Make vim-surround things repeatable with .
    { "tpope/vim-surround" }, -- ysiw syntax for surrounding
    {
      "anuvyklack/windows.nvim",
      dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim",
      },
      config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require("windows").setup()
      end,
    },
    {
      "folke/twilight.nvim",
      opts = {
        dimming = {
          alpha = 0.25, -- amount of dimming
          inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 3, -- amount of lines we will try to show around the current line
      },
    },
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

    -- Source the ../plugins directory for overriding LazyVim plugins.
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight-night" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
