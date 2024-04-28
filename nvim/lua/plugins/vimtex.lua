return {
  {
    "lervag/vimtex", -- latex plugin
    lazy = false, -- docs say to not load lazily, but undo if slow to start
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
}
