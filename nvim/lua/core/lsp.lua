vim.lsp.enable({
  "clangd",
  "gopls",
  "html",
  "jinja_lsp",
  "lua_ls",
  "pylsp",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "ts_ls",
})

vim.lsp.config("clangd", {
  cmd = { "clangd", "--header-insertion=never", "--experimental-modules-support" },
})
