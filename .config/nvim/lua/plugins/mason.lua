return {
    "williamboman/mason.nvim",
    opts = {
        lazy = false,
    },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function ()
        local mason = require("mason")
        local lspconfig = require("mason-lspconfig")
        local tool_installer = require("mason-tool-installer")

        mason.setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        }

        lspconfig.setup {
            ensure_installed = { 
                "pyright",
                "lua_ls",
                "clangd",
                "omnisharp",
                "julials",
                "html"
            },
        }

        tool_installer.setup {
            ensure_installed = {
                "stylua"
            }
        }
    end
}
