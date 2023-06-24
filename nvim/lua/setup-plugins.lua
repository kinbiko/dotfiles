local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- delay notifications till vim.notify was replaced or after 500ms
local notifs = {}
local function temp(...)
  table.insert(notifs, vim.F.pack_len(...))
end

local orig = vim.notify
vim.notify = temp

local timer = vim.loop.new_timer()
local check = vim.loop.new_check()

---@diagnostic disable: need-check-nil
local replay = function()
  timer:stop()
  check:stop()
  if vim.notify == temp then
    vim.notify = orig -- put back the original notify if needed
  end
  vim.schedule(function()
    ---@diagnostic disable-next-line: no-unknown
    for _, notif in ipairs(notifs) do
      vim.notify(vim.F.unpack_len(notif))
    end
  end)
end

-- wait till vim.notify has been replaced
check:start(function()
  if vim.notify ~= temp then
    replay()
  end
end)
-- or if it took more than 500ms, then something went wrong
timer:start(500, 0, replay)

require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version = "*" }, -- manage itself
    { import = "plugins" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
