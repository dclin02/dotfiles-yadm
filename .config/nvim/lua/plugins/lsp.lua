local call = vim.env.NVIM_CALL ~= nil

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          settings = {
            gopls = {
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-mocks" },
              -- staticcheck roda análise pesada no repo inteiro; não ajuda a navegar
              staticcheck = not call,
            },
          },
        },
        -- não servem para navegar: em call ficam desligados
        tailwindcss = { enabled = not call },
        eslint = { enabled = not call },
      },
    },
  },
  -- nvim-lint roda golangci-lint/markdownlint ao abrir cada arquivo
  { "mfussenegger/nvim-lint", cond = not call },
}
