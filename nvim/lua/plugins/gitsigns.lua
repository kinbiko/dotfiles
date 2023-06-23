return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "<leader>gn", gs.next_hunk, "Next Hunk")
        map("n", "<leader>gp", gs.prev_hunk, "Previous Hunk")
        map("n", "<leader>ga", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gu", gs.reset_hunk, "Undo hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gb", gs.blame_line, "Toggle blame")
        map("n", "<leader>gw", gs.preview_hunk_inline, "View hunk")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
      end,
    },
  },
}
