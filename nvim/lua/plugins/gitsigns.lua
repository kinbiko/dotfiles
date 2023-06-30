return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "新" },
        change = { text = "∂" },
        delete = { text = "消" }, -- the line below has been deleted
        topdelete = { text = "‾" }, -- something has been deleted from the top of the file
        changedelete = { text = "▎" },
        untracked = { text = "?" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = buffer, desc = desc })
        end

        map("<leader>gn", gs.next_hunk, "Next Hunk")
        map("<leader>gp", gs.prev_hunk, "Previous Hunk")
        map("<leader>ga", gs.stage_hunk, "Stage hunk")
        map("<leader>gu", gs.reset_hunk, "Undo hunk")
        map("<leader>gr", gs.reset_hunk, "Reset hunk")
        map("<leader>gb", gs.blame_line, "Toggle blame")
        map("<leader>gw", gs.preview_hunk_inline, "View hunk")
        map("<leader>gd", gs.diffthis, "Diff This")
      end,
    },
  },
}
