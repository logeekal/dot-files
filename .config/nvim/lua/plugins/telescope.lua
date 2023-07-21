local opts = { noremap = true, silent = true }

local setup = function()
  require('telescope').setup({
    defaults = {
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

local init = function()
  local dropDownTheme = require('telescope.themes').get_dropdown({
    layout_config = {
      width = 0.9,
      preview_cutoff = 1,
      height = 0.5,
      mirror = true,
      anchor = 'N',
      prompt_position = 'top',
    },
  })
  local telescope = require('telescope.builtin')
  vim.keymap.set('n', '<leader>rg', function()
    telescope.live_grep(dropDownTheme)
  end, opts)
  vim.keymap.set('n', '<leader>pa', function()
    telescope.find_files(dropDownTheme)
  end, opts)
  vim.keymap.set('n', '<leader>p', function()
    telescope.git_files(dropDownTheme)
  end, opts)
  --vim.keymap.set('n', "<leader>gr", function() telescope.lsp_references(dropDownTheme) end, opts)
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
    init = init,
    cmd = 'Telescope',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'arch -arm64 make',
  },
}
