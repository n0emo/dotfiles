return {
  "windwp/nvim-autopairs",
  opts = {
    disable_filetype = { "TelescopePrompt", "vim" },
  },

  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,
      enable_check_bracket_line = false,
    })
  end
}
