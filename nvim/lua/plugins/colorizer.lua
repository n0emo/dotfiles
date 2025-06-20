return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*",
      css = { names = true, css = true },
      html = { css = true },
      svelte = { css = true },
    }, {
      names = false,
    })
  end,
}
