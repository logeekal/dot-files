local utils = require('utils.path')

local function get_custom_file_name(complete_file_name)
  local cached_project_root = nil
  -- converts absolution path to path relative to git or home_dir
  -- if not cached_project_root then
  --   root_dir = util.root_pattern('.git'),
  local base_dir = utils.get_project_root_display() .. "/"
  -- expand str can sometime abbreivate path.. use fnamemodify to get full path

  local user_home_dir = vim.loop.os_homedir() .. "/"
  if not base_dir or base_dir == '' then
    -- replace home dir with ~
    cached_project_root = complete_file_name:gsub(user_home_dir, '~')
  else
    cached_project_root = complete_file_name:gsub(base_dir, '')
  end
  -- print('cached_project_root',
  --   cached_project_root .. ' complete_file_name: ' .. complete_file_name .. ' base_dir: ' .. base_dir)
  -- end

  return cached_project_root
end


-- -- Autocommand to force a Lualine refresh when a new buffer is read
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "BufWritePost" }, {
--   callback = function()
--     -- Invalidate cache for the project root component to force recalculation
--     cached_project_root = nil
--   end,
-- })

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
          lualine_y = { 'encoding', 'fileformat', 'filetype' },
          -- progress bar by Karen
          -- lualine_y = {
          --   {
          --     function()
          --       local current_line = vim.fn.line('.')
          --       local total_lines = vim.fn.line('$')
          --       local width = 10
          --       if total_lines <= 1 then
          --         return string.rep('▁', width)
          --       end
          --       local progress = (current_line - 1) / (total_lines - 1)
          --       local filled = math.floor(progress * width + 0.5)
          --       local bar = string.rep('█', filled)
          --           .. string.rep('▁', width - filled)
          --       return bar
          --     end,
          --     color = { fg = '#5E81AC' }, -- light blue
          --     separator = '',
          --   },
          -- },
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
              -- will not shorten the path parts
              shorting_target = 0,
              path = 2,
              fmt = get_custom_file_name,
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
