return {
  -- add theme
  {
    "akinsho/horizon.nvim",
    lazy = true,
    name = "horizon",
  },

  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "horizon",
    },
  },
}
