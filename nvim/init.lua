---@diagnostic disable: lowercase-global

local function main()
  set_options()
  install_plugins()
  configure_lsp()
  set_keymap()
  highlight_yanked_text()
end

function set_options()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.g.have_nerd_font = false

  vim.opt.showmode = false

  vim.opt.clipboard = "unnamedplus"

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.scrolloff = 8
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.softtabstop = 4
  vim.opt.expandtab = true

  vim.opt.splitbelow = true
  vim.opt.splitright = true

  vim.opt.smartcase = true
  vim.opt.ignorecase = true

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

  vim.opt.signcolumn = "yes"

  vim.opt.wrap = true

  local desktop = os.getenv("XDG_CURRENT_DESKTOP")
  if desktop and desktop:find("GNOME") then
    vim.g.clipboard = {
      name = "xclip",
      copy = {
        ["+"] = "xclip -selection clipboard",
        ["*"] = "xclip -selection primary",
      },
      paste = {
        ["+"] = { "xclip", "-selection", "clipboard", "-o" },
        ["*"] = { "xclip", "-selection", "primary", "-o" },
      },
      cache_enabled = true,
    }
  end
end

function install_plugins()
  vim.pack.add({
    -- Dependencies
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/kevinhwang91/promise-async",

    -- Plugins
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/xiyaowong/transparent.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/wakatime/vim-wakatime",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/cbochs/grapple.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/chrisgrieser/nvim-lsp-endhints",
    { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2") },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/catgoose/nvim-colorizer.lua",
    "https://github.com/johmsalas/text-case.nvim",
  })

  vim.cmd.colorscheme("kanagawa")

  require("nvim-web-devicons").setup()

  require("transparent").setup()

  require("oil").setup({
    columns = {
      "icon",
      -- "permissions",
      "size",
      "mtime",
    },
  })

  require("grapple").setup()

  require("which-key").setup()

  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "build" },
      path_display = { "absolute" },
      mappings = {
        i = {
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
        },
      },
    },
  })

  require("todo-comments").setup({
    search = {
      pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
    },
    highlight = {
      pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
    },
  })

  setup_treesitter()

  vim.o.foldcolumn = "0"
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  require("ufo").setup({
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
    },
  })

  require("lsp-endhints").setup({
    icons = {
      type = ": ",
      parameter = ": ",
      offspec = ": ", -- hint kind not defined in official LSP spec
      unknown = ": ", -- hint kind is nil
    },
    label = {
      truncateAtChars = 100,
      padding = 1,
      marginLeft = 0,
      sameKindSeparator = ", ",
    },
    extmark = {
      priority = 50,
    },
    autoEnableHints = true,
  })

  require("luasnip.loaders.from_snipmate").lazy_load({})

  require("blink.cmp").setup({
    keymap = {
      preset = "none",
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      ["<C-o>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true,
      },
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },
    },

    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "lua" },
  })

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      cpp = { "clang-format" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },
  })

  require("lualine").setup({
    options = {
      theme = "kanagawa",
    },
    sections = {
      lualine_b = { "grapple" },
    },
  })

  require("colorizer").setup({
    "*",
    css = { names = true, css = true },
    html = { css = true },
    svelte = { css = true },
  }, {
    names = false,
  })

  require("textcase").setup({})
  require("telescope").load_extension("textcase")
end

function configure_lsp()
  vim.lsp.enable({
    "clangd",
    "gopls",
    "html",
    "jinja_lsp",
    "just",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "tinymist",
    "ts_ls",
  })

  vim.lsp.config("clangd", {
    cmd = { "clangd", "--header-insertion=never" },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client ~= nil and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end
      require("lsp-endhints").enable()
    end,
  })
end

function set_keymap()
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
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })

  vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { silent = true, noremap = true, desc = "LSP: Toggle diagnostics" })

  vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { silent = true, noremap = true, desc = "LSP: Open float" }
  )
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

  vim.keymap.set("n", "gmp", function()
    require("conform").format({ async = true })
  end, { desc = "LSP: Reformat file" })

  vim.keymap.set({ "n", "x" }, "<leader>rr", function()
    require("telescope").extensions.refactoring.refactors()
  end, { desc = "Refactor" })

  vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "LSP: Open all folds" })
  vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "LSP: Close all folds" })

  vim.keymap.set("n", "<leader>m", require("grapple").toggle, { desc = "Mark/unmark file" })
  vim.keymap.set("n", "M", "<CMD>Telescope grapple tags<CR>", { desc = "Show all tags" })

  for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, "<CMD>Grapple select index=" .. i .. "<CR>", {
      desc = "Switch to tag " .. i,
    })
  end

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
  end, { desc = "Buffer Local Keymaps (which-key)" })

  vim.keymap.set("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>")
end

function highlight_yanked_text()
  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })
end

function setup_treesitter()
  local treesitter = require("nvim-treesitter")

  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if name == "nvim-treesitter" and kind == "update" then
        if not ev.data.active then
          vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd("TSUpdate")
      end
    end,
  })

  treesitter.setup()

  local ensureInstalled = {
    "c",
    "c_sharp",
    "cpp",
    "gleam",
    "go",
    "haskell",
    "javascript",
    "lua",
    "python",
    "rust",
    "svelte",
    "typescript",
  }

  local alreadyInstalled = require("nvim-treesitter.config").get_installed()
  local parsersToInstall = vim
    .iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()

  treesitter.install(parsersToInstall)

  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      -- Enable treesitter highlighting and disable regex syntax
      pcall(vim.treesitter.start)
      -- Enable treesitter-based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  treesitter.update()
end

main()
