-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " " -- This is already the LazyVim default, but explicitly stating again for clarity.
vim.g.maplocalleader = "," -- This is ' ' by default as LazyVim has it defined.

-- LazyVim sets this to 'unnamedplus' which pollutes the system clipboard for every yank/delete/etc.
-- This unsets this.
vim.opt.clipboard = ""
