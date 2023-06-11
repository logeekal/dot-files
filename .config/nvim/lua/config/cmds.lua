vim.api.nvim_create_user_command('RR', 'Telescope registers', {})


vim.api.nvim_create_user_command(
  'CSToggle',
  function()
    local current_theme = vim.g.colors_name
    require(current_theme).toggle()
  end,
  {}
)
