return {
  {
    "goolord/alpha-nvim",
    opts = function()
      require("alpha.term")

      local function button(sc, txt, keybind)
        return {
          on_press = function()
            local key = vim.api.nvim_replace_termcodes(keybind or sc .. "<Ignore>", true, false, true)
            vim.api.nvim_feedkeys(key, "t", false)
          end,
          type = "button",
          val = txt,
          opts = {
            hl_shortcut = "AlphaShortcut",
            position = "center",
            shortcut = sc,
            width = 20,
            keymap = { "n", sc, keybind, { noremap = true, silent = true, nowait = true } },
          },
        }
      end

      local section = {
        terminal = {
          type = "terminal",
          command = "cat | " .. "$DOTFILES_DIR/config/nvim/art/thisisfine.sh",
          width = 46,
          height = 25,
          opts = { redraw = true },
        },
        buttons = {
          type = "group",
          val = {
            button("n", " New", ":ene<CR>"),
            button("l", " Lazy", ":Lazy<CR>"),
            button("m", " Mason", ":ene<cr>:Mason<CR>"),
            button("q", " Quit", ":qa<CR>"),
          },
        },
        footer = {},
      }

      return {
        section = section,
        opts = {
          layout = {
            section.terminal,
            { type = "padding", val = 6 },
            section.buttons,
          },
        },
      }
    end,
  },
}
