return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-mocks" },
            },
          },
        },
      },
    },
  },
}
