return {
  -- Set up transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    name = "transparent",
  },

  -- Add colorscheme
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
