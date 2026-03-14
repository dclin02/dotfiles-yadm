-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.cmd([[set jumpoptions+=stack]])

vim.opt.statuscolumn = "%s %l %r"

lvim.colorscheme = "onedarker"

lvim.format_on_save = {
  enabled = true,
  pattern = { "*.lua", "*.py", "*.go" },
  timeout = 1000,
}

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-k>"] = "<cmd>lua vim.lsp.buf.signature_help()<cr>"

lvim.keys.normal_mode["<A-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<A-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<A-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-S-h>"] = ":BufferLineMovePrev<CR>"
lvim.keys.normal_mode["<A-S-l>"] = ":BufferLineMoveNext<CR>"

lvim.builtin.which_key.mappings["r"] = {
  "<cmd>RnvimrToggle<cr>",
  "Ranger",
}
lvim.builtin.which_key.mappings["lR"] = {
  "<cmd>lua vim.diagnostic.reset()<cr>",
  "Reset Diagnostics",
}
lvim.builtin.which_key.mappings["lo"] = {
  "<cmd>SymbolsOutline<cr>",
  "Symbols Outline",
}
lvim.builtin.which_key.mappings["gD"] = {
  name = "Diff View Plugin",
  o = { "<cmd>DiffviewOpen<cr>", "Open" },
  c = { "<cmd>DiffviewClose<cr>", "Close" },
  f = { "<cmd>DiffviewFileHistory<cr>", "File History" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Todo Comments",
  q = { "<cmd>TodoQuickFix<cr>", "Quick Fix" },
  l = { "<cmd>TodoLocList<cr>", "Loc List" },
  t = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
}

lvim.builtin.which_key.mappings["ss"] = {
  name = "Spectre Panel for Search and Replace",
  t = { "<cmd>lua require'spectre'.toggle()<CR>", "Toggle Spectre" },
  s = { "<cmd>lua require'spectre'.toggle()<CR>", "Toggle Spectre" },
  c = { "<cmd>lua require'spectre'.open_visual({select_word=true})<CR>", "Search current word" },
  f = { "<cmd>lua require'spectre'.open_file_search({select_word=true})<CR>", "Search on current file" },
}
lvim.builtin.which_key.mappings["W"] = {
  "<cmd>set wrap!<cr>",
  "Toggle Word Wrap",
}
lvim.builtin.which_key.mappings["C"] = {
  name = "Copilot Chat",
  o = { "<cmd>CopilotChatOpen<cr>", "Open Chat Window" },
  t = { "<cmd>CopilotChatToggle<cr>", "Toggle Chat Window" },
  r = { "<cmd>CopilotChatReset<cr>", "Reset Chat Window" },
}
lvim.builtin.which_key.mappings["U"] = {
  name = "Utils",
  S = { "<cmd>wshada!<cr>", "Clear ShaDa File" },
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.lir.show_hidden_files = true

lvim.builtin.dap.ui.config.render.max_type_length = 20

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ensure_installed = {
  "comment",
  "markdown_inline",
  "regex",
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "hcl",
  "terraform",
}

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "goimports",     filetypes = { "go" } },
  -- { command = "gofumpt",       filetypes = { "go" } },
  -- { command = "/home/berin/go/bin/gofumpt", filetypes = { "go" } },
  { command = "gofmt",         filetypes = { "go" } },
  { command = "black",         filetypes = { "python" } },
  { command = "terraform_fmt", filetypes = { "terraform" } },
})

lvim.plugins = {
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  "lambdalisue/vim-suda",
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "kevinhwang91/rnvimr",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_enable_bw = 1
      vim.g.rnvimr_hide_gitignore = 0
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "p00f/nvim-ts-rainbow" },
  {
    "ellisonleao/glow.nvim",
    ft = { "markdown" }
    -- run = "yay -S glow"
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      local opts = {
        -- char = "▏",
        filetype_exclude = {
          "alpha",
          "help",
          "terminal",
          "dashboard",
          "lspinfo",
          "lsp-installer",
          "mason",
        },
        buftype_exclude = { "terminal" },
        bufname_exclude = { "config.lua" },

        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        -- use_treesitter = false,
      }

      require("indent_blankline").setup(opts)
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- {
  --   "romgrk/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup {
  --       enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
  --       throttle = true, -- Throttles plugin updates (may improve performance)
  --       max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
  --       patterns = {
  --         -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
  --         -- For all filetypes
  --         -- Note that setting an entry here replaces all other patterns for this entry.
  --         -- By setting the 'default' entry below, you can control which nodes you want to
  --         -- appear in the context window.
  --         default = {
  --           'class',
  --           'function',
  --           'method',
  --         },
  --       },
  --     }
  --   end
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
}
