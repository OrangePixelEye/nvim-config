return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup({
      filesystem = {
        filtered_items = {
          visible = true, -- this is what you want: if you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      }
    })
    -- this command opens the filesystem
      vim.keymap.set("n", "<leader>b", ":Neotree filesystem reveal left<CR>")
  end,
}
