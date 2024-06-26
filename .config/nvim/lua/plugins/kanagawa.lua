return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colorscheme = "kanagawa",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  config = function()
    vim.cmd.colorscheme("kanagawa")
  end,
}
