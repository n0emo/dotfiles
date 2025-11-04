vim.lsp.enable({
  "clangd",
  "gopls",
  "html",
  "jinja_lsp",
  "just",
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

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class: "(.*)"',
        },
      },
      includeLanguages = {
        rust = "html",
      },
    },
  },
  filetypes = { "rust" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
    require("lsp-endhints").enable()
  end,
})
