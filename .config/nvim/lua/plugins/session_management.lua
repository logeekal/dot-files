local load_alpha_dashboard = function()
  local ok = pcall(require, 'alpha')
  if ok then
    vim.cmd([[Alpha]])
  end
end

local setup_persisted = function()
  local persisted = require('persisted')
  persisted.setup({
    autostart = true, -- Automatically start the plugin on load?

    -- Function to determine if a session should be saved
    ---@type fun(): boolean
    should_save = function()
      return true
      -- print('Checking if session should be saved')
      -- if vim.g.started_with_stdin then
      --   print('Session not saved because started with stdin')
      --   return false
      -- end
      --
      -- local arg_first_real = vim.uv.fs_realpath(vim.fn.argv()[0])
      -- vim.print('Argv (real): ', arg_first_real, '----------------------')
      --
      -- if vim.fn.argc() == 0 then
      --   print('Session saved because arguments were passed')
      --   print('Arguments:', vim.fn.argv())
      --   return true
      -- else
      --   print('Session not saved because no arguments were passed')
      --   return false
      -- end
    end,

    save_dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'), -- Directory where session files are saved

    follow_cwd = true, -- Change the session file to match any change in the cwd?
    use_git_branch = true, -- Include the git branch in the session file name?
    autoload = true, -- Automatically load the session for the cwd on Neovim startup?

    -- Function to run when `autoload = true` but there is no session to load
    ---@type fun(): any
    on_autoload_no_session = function()
      load_alpha_dashboard()
    end,

    allowed_dirs = {}, -- Table of dirs that the plugin will start and autoload from
    ignored_dirs = {}, -- Table of dirs that are ignored for starting and autoloading

    telescope = {
      mappings = {
        -- Mappings for managing sessions in Telescope
        copy_session = '<C-c>',
        change_branch = '<C-b>',
        delete_session = '<C-d>',
      },
      icons = {
        -- icons displayed in the Telescope picker
        selected = ' ',
        dir = '  ',
        branch = ' ',
      },
    },
  })
end

return { {
  'olimorris/persisted.nvim',
  config = setup_persisted,
} }
