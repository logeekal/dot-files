local function custom_filename_fmt(str)
  -- converts absolution path to path relative to git or home_dir
  local git_dir = vim.loop.cwd() .. '/.git'
  -- expand str
  local complete_filename = vim.fn.expand(str)
  local user_home_dir = git_dir:gsub('.git', '')
  if not git_dir or git_dir == '' then
    user_home_dir = vim.loop.os_homedir() + '/'
    return complete_filename:gsub(user_home_dir, '~')
  end
  -- replace home dir with ~
  return complete_filename:gsub(user_home_dir, '')
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          globalstatus = true,
          theme = 'auto',
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_c = {
            {
              'filename',
              icons_enabled = true,
              path = 3,
            },
          },
          lualine_x = {
            function()
              -- invoke `progress` here.
              return require('lsp-progress').progress()
            end,
          },
          -- lualine_x = {
          --   {
          --     require('noice').api.statusline.mode.get,
          --     cond = require('noice').api.statusline.mode.has,
          --     color = { fg = '#ff9e64' },
          --   },
          -- },
          lualine_z = {
            'location',
            {
              function()
                return ' ' .. os.date('%R')
              end,
            },
          },
        },

        -- One disadvantahe of tabline that much because it does not have
        -- Nvim-tree offset + Whenever nvim tree is expanded
        -- tab is hijacked by nvim tree
        -- but this is only good solution I have discovered so far
        tabline = {
          lualine_a = {
            {
              'filename',
              path = 3,
              fmt = custom_filename_fmt,
              icons_enabled = true,
              file_status = true,
            },
          },
          lualine_b = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })

      vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = 'lualine_augroup',
        pattern = 'LspProgressStatusUpdated',
        callback = require('lualine').refresh,
      })
    end,
  },
}
