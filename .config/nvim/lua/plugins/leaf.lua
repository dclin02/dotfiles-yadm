-- leaf (markdown viewer) rodando em terminais do snacks.
-- Ao sair do leaf com `q` a janela fecha sozinha.

local function git_root()
  return Snacks.git.get_root() or vim.fn.getcwd()
end

local float_win = { position = "float", width = 0.9, height = 0.9, border = "rounded" }

-- abre um diff (string de comando git) no modo diff do leaf, em float
local function leaf_diff(git_cmd)
  Snacks.terminal.open({ "sh", "-c", git_cmd .. " | leaf-diff" }, {
    cwd = git_root(),
    win = float_win,
  })
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>cL",
        function()
          local file = vim.api.nvim_buf_get_name(0)
          Snacks.terminal.toggle({ "leaf", "--watch", file }, {
            win = { position = "right", width = 0.45 },
          })
        end,
        ft = { "markdown" },
        desc = "Leaf preview (watch)",
      },
      {
        "<leader>cP",
        function()
          Snacks.terminal.open({ "leaf", vim.api.nvim_buf_get_name(0) }, { win = float_win })
        end,
        ft = { "markdown" },
        desc = "Leaf preview (float)",
      },
      {
        "<leader>gm",
        function()
          local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
          leaf_diff("git diff HEAD --no-ext-diff -- " .. file)
        end,
        desc = "Leaf diff (arquivo atual)",
      },
      {
        "<leader>gM",
        function()
          leaf_diff("git diff HEAD --no-ext-diff -- '*.md' '*.markdown' '*.mdx'")
        end,
        desc = "Leaf diff (markdown do repo)",
      },
    },
  },
}
