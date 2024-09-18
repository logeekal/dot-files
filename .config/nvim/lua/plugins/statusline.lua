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
          globalstatus = true,
          theme = 'auto',
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 3,
            },
          },
          lualine_x = {
            {
              require('noice').api.statusline.mode.get,
              cond = require('noice').api.statusline.mode.has,
              color = { fg = '#ff9e64' },
            },
          },
          lualine_z = {
            'location',
            {
              function()
                return ' ' .. os.date('%R')
              end,
            },
          },
        },

        -- disabled lualine tabline because it does not have
        -- Nvim-tree offset + Whenever nvim tree is expanded
        -- tab is hijacked by nvim tree
        tabline = {
          lualine_a = {
            {
              'filename',
              path = 3,
            },
          },
          lualine_b = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
