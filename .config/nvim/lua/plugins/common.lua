return {

  {
    'karb94/neoscroll.nvim',
    config = function()
      -- neoscroll highjacking <C-E> from Nvim Tree
      require('neoscroll').setup()
    end,
    custom_keys = {
      ['<C-E>'] = false,
    },
    event = { 'BufReadPost' },
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup()
    end,
  },
  {
    'dstein64/vim-startuptime',
    lazy = false,
  },
  'neovim/nvim-lspconfig',
  -- 'tpope/vim-fugitive',
  'nvim-tree/nvim-web-devicons',
  {
    'heavenshell/vim-jsdoc',
    build = 'npm install -g lehre',
  },
  'rafamadriz/friendly-snippets',
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = '1.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
