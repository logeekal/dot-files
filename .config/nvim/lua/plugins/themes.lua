return {
  'navarasu/onedark.nvim',
  opts = {
    style = 'cool',
    transparent = 'false',
  },

  -- tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'moon' },
  },

  -- catppuccin
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
  },

  { 'EdenEast/nightfox.nvim' },
}
