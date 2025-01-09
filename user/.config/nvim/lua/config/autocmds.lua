-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

-- Setup transparent background for neo-tree
require("transparent").clear_prefix("NeoTree")

-- Set filetype for .ato files to python
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ato",
  command = "set filetype=python",
})
