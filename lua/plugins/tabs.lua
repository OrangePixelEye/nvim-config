return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    config = function()
      require('barbar').setup {
        -- ... other configurations ...
      }

      vim.keymap.set('n', '<leader>n', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<leader>m', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
    end,
  },
}
