return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              -- ... other gopls settings
              directoryFilters = {
                "-**/node_modules", -- Example: Exclude node_modules at any depth
                "-**/mocks",
                "-.git", -- Example: Exclude .git folder
              },
              -- ...
            },
          },
        },
      },
    },
  },
}
