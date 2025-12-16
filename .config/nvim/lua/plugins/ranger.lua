return {
  {
    "kevinhwang91/rnvimr",
    -- rnvimr is vimscript-y and uses g: variables, so set them in `init`
    init = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_enable_bw = 1
      vim.g.rnvimr_hide_gitignore = 0
    end,
    keys = {
      { "<leader>r", "<cmd>RnvimrToggle<cr>", desc = "Ranger" },
    },
  },
}
