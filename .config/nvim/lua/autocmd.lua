vim.cmd([[autocmd BufNewFile,BufRead *.cs setlocal errorformat=\ %#%f(%l\\\,%c):\ %m]])
vim.cmd([[autocmd BufNewFile,BufRead *.cs setlocal makeprg=dotnet\ build\ /property:GenerateFullPaths=true]])

vim.cmd([[autocmd BufNewFile,BufRead *.adb setlocal makeprg=make]])

vim.cmd([[autocmd BufNewFile,BufRead *.py setlocal makeprg=python]])
