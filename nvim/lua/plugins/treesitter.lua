return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install({
        "bash", "c", "css", "csv", "cue", "diff", "dockerfile",
        "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
        "go", "gomod", "gosum", "gowork", "html", "javascript", "jq",
        "json", "json5", "jsonc", "latex", "lua", "luadoc", "luap",
        "markdown", "markdown_inline", "php", "proto", "python", "query",
        "regex", "ruby", "rust", "sql", "terraform", "tsx", "typescript",
        "vim", "vimdoc", "xml", "yaml",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
  },
}
