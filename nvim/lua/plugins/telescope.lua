return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "build" },
        path_display = { "absolute" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

    vim.keymap.set("n", "fr", builtin.lsp_references)
    vim.keymap.set("n", "fD", builtin.lsp_definitions)
    vim.keymap.set("n", "fi", builtin.lsp_implementations)
    vim.keymap.set("n", "ft", builtin.lsp_type_definitions)
    vim.keymap.set("n", "fd", builtin.diagnostics)

    vim.keymap.set("n", "fs", builtin.git_status)
  end,
}
