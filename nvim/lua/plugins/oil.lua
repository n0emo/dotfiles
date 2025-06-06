return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = {
    {
      "echasnovski/mini.icons",
      opts = {}
    }
  },
  lazy = false,

  config = function ()
    require("oil").setup({
      columns = {
        "icon",
        -- "permissions",
        "size",
        -- "mtime",
      },
    })
  end
}
