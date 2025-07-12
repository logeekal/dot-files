local opts = { noremap = true, silent = true }

local setup = function()
  require('telescope').setup({
    defaults = {
      border = false,
      dynamic_preview_title = true,
      layout_config = {
        vertical = {
          mirror = true,
          prompt_position = 'top',
        },
      },
    },
    pickers = {
      --find_files = {
      --theme = "dropdown",
      --},
      --git_files = {
      --theme = "dropdown"
      --}
    },
  })

  require('telescope').load_extension('fzf')
  require('telescope').load_extension('persisted')
  --require('telescope').load_extension('media_files')
end

return {
  'nvim-lua/plenary.nvim',
  'BurntSushi/ripgrep',
  'nvim-lua/popup.nvim',
  'nvim-telescope/telescope-media-files.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'telescope-fzf-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'olimorris/persisted.nvim',
    },
    config = setup,
    cmd = 'Telescope',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'arch -arm64 make',
  },
}
