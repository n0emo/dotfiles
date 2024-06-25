vim.cmd([[autocmd BufNewFile,BufRead *.cs setlocal errorformat=\ %#%f(%l\\\,%c):\ %m]])
vim.cmd([[autocmd BufNewFile,BufRead *.cs setlocal makeprg=dotnet\ build\ /property:GenerateFullPaths=true]])

vim.cmd([[autocmd BufNewFile,BufRead *.adb setlocal makeprg=make]])

vim.cmd([[autocmd BufNewFile,BufRead *.py setlocal makeprg=python]])

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
