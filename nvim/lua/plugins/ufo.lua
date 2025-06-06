return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async"
  },

  config = function ()
    local ufo = require("ufo")

    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    ufo.setup({
      close_fold_kinds_for_ft = {
        default = {'imports', 'comment'},
      },
    })
  end
}
