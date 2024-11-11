-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

-- Setup transparent background for neo-tree
require("transparent").clear_prefix("NeoTree")

-- Fix notifications about transparent background_colour
require("notify").setup({ background_colour = "#000000" })
