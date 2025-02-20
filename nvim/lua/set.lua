vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.updatetime = 250

vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"
vim.opt.cursorline = true

vim.opt.hlsearch = true

vim.opt.signcolumn = 'yes'

vim.opt.wrap = true

--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--vim.opt.foldlevelstart = 99
