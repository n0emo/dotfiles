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

    vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>")
  end,
}
