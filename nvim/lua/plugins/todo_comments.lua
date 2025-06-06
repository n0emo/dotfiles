return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { },
  config = function()
    require("todo-comments").setup({
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]]
      },
      highlight = {
        pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]]
      },
    })
  end,
}
