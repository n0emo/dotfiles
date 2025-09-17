-- Basic
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("i", "jk", "<Esc>", { desc = "Go to normal mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Go to normal mode" })

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move left" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move right" })

vim.keymap.set("n", "<leader>w", "<CMD>bw<CR>", { desc = "Close current buffer" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- LSP
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = "LSP: Toggle diagnostics" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: Find references" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Go to next diagnostic" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true, noremap = true, desc = "LSP: Open float" })
vim.keymap.set("n", "<leader>ss", "<CMD>LspClangdSwitchSourceHeader<CR>", {
  desc = "LSP (Clangd): Switch between source and header",
})

-- Telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Find help tags" })

vim.keymap.set("n", "<leader>sw", telescope_builtin.spell_suggest, { desc = "Spell suggest" })

vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references, { desc = "Find LSP references" })
vim.keymap.set("n", "<leader>fD", telescope_builtin.lsp_definitions, { desc = "Find LSP definitions" })
vim.keymap.set("n", "<leader>fi", telescope_builtin.lsp_implementations, {
  desc = "Find LSP implementations",
})
vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, { desc = "Find LSP symbols" })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "Find LSP diagnostics" })

vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Find TODO comments" })

-- Conform
vim.keymap.set("n", "gmp", function()
  require("conform").format({ async = true })
end, { desc = "LSP: Reformat file" })

-- Refactoring
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("telescope").extensions.refactoring.refactors()
end, { desc = "Refactor" })

-- Ufo
local ufo = require("ufo")
vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "LSP: Open all folds" })
vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "LSP: Close all folds" })

-- Grapple
vim.keymap.set("n", "<leader>m", require("grapple").toggle, { desc = "Mark/unmark file" })
vim.keymap.set("n", "M", "<CMD>Telescope grapple tags<CR>", { desc = "Show all tags" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<CMD>Grapple select index=" .. i .. "<CR>", {
    desc = "Switch to tag " .. i,
  })
end
