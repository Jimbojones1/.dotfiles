-- lua/plugins/colorscheme.lfa
return {
  -- {
  -- 'sainnhe/everforest',
  -- priority = 1000,
  -- config = function()
  -- Everforest options
  --     vim.g.everforest_background = 'medium'
  --     vim.g.everforest_enable_italic = 1
  --
  --     -- actually apply the theme
  --     vim.cmd 'colorscheme everforest'
  --   end,
  -- },
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- load this first
  --   config = function()
  --     vim.opt.termguicolors = true
  --     require('tokyonight').setup {
  --       style = 'storm',
  --       -- you can still tweak on_colors here if you like
  --     }
  --     vim.cmd 'colorscheme tokyonight'
  --     -- optional: bright cursor for contrast
  --     vim.cmd 'highlight Cursor guifg=NONE guibg=#FFD700'
  --   end,
  -- },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      -- choose medium contrast for the dark variant
      vim.g.gruvbox_contrast_dark = 'medium'
      vim.g.gruvbox_invert_selection = '0'

      vim.cmd 'colorscheme gruvbox'
      vim.cmd 'highlight Cursor guifg=NONE guibg=#FABD2F ctermbg=214'
      vim.cmd 'highlight! FloatBorder guifg=#7fa2e3 guibg=NONE'
      -- vim.cmd 'highlight! FloatBorder guifg=#83a598 guibg=NONE'
    end,
  },
}
