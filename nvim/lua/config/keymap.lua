-- Basic
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- LSP
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ss", "<CMD>ClangdSwitchSourceHeader<CR>")

-- Telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})

vim.keymap.set("n", "<leader>sw", telescope_builtin.spell_suggest, {})

vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references)
vim.keymap.set("n", "<leader>fD", telescope_builtin.lsp_definitions)
vim.keymap.set("n", "<leader>fi", telescope_builtin.lsp_implementations)
vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics)

vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>")

-- Conform
vim.keymap.set("n", "gmp", function()
  require("conform").format({ async = true })
end)

-- Luasnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function()
  ls.expand()
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-L>", function()
  ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-J>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- Refactoring
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("telescope").extensions.refactoring.refactors()
end)

-- Ufo
local ufo = require("ufo")
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
