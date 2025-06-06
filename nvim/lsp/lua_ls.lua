return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luacheckrc",
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml",
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
