return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "\\<.*\\>" }, -- * and # usage
              { find = "/.*" }, -- starting a search with /
              { find = ".*Pattern not found.*" }, -- not finding anything with a search
            },
          },
          view = "mini",
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
