return {
  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = function()
      return {
        { "<leader>R", "", desc = "+refactor", mode = { "n", "x" } },
        {
          "<leader>Rs",
          pick,
          mode = { "n", "x" },
          desc = "Refactor",
        },
        {
          "<leader>Ri",
          function()
            return require("refactoring").refactor("Inline Variable")
          end,
          mode = { "n", "x" },
          desc = "Inline Variable",
          expr = true,
        },
        {
          "<leader>Rb",
          function()
            return require("refactoring").refactor("Extract Block")
          end,
          mode = { "n", "x" },
          desc = "Extract Block",
          expr = true,
        },
        {
          "<leader>Rf",
          function()
            return require("refactoring").refactor("Extract Block To File")
          end,
          mode = { "n", "x" },
          desc = "Extract Block To File",
          expr = true,
        },
        {
          "<leader>RP",
          function()
            require("refactoring").debug.printf({ below = false })
          end,
          desc = "Debug Print",
        },
        {
          "<leader>Rp",
          function()
            require("refactoring").debug.print_var({ normal = true })
          end,
          mode = { "n", "x" },
          desc = "Debug Print Variable",
        },
        {
          "<leader>Rc",
          function()
            require("refactoring").debug.cleanup({})
          end,
          desc = "Debug Cleanup",
        },
        {
          "<leader>Rf",
          function()
            return require("refactoring").refactor("Extract Function")
          end,
          mode = { "n", "x" },
          desc = "Extract Function",
          expr = true,
        },
        {
          "<leader>RF",
          function()
            return require("refactoring").refactor("Extract Function To File")
          end,
          mode = { "n", "x" },
          desc = "Extract Function To File",
          expr = true,
        },
        {
          "<leader>Rx",
          function()
            return require("refactoring").refactor("Extract Variable")
          end,
          mode = { "n", "x" },
          desc = "Extract Variable",
          expr = true,
        },
        {
          "<leader>Rp",
          function()
            require("refactoring").debug.print_var()
          end,
          mode = { "n", "x" },
          desc = "Debug Print Variable",
        },
      }
    end,
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
      -- i.e. [Refactor] Inlined 3 variable occurrences
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      if LazyVim.has("telescope.nvim") then
        LazyVim.on_load("telescope.nvim", function()
          require("telescope").load_extension("refactoring")
        end)
      end
    end,
  },
}
