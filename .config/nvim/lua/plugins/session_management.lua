local setup_persisted = function()
  require('persisted').setup({
    silent = false,        -- silent nvim message when sourcing session file
    use_git_branch = true, -- create session files based on the branch of the git enabled repository
    autosave = true,       -- automatically save session files when exiting Neovim
    should_autosave = nil, -- function to determine if a session should be autosaved
    autoload = true,       -- automatically load the session for the cwd on Neovim startup
    -- on_autoload_no_session = nil,         -- function to run when `autoload = true` but there is no session to load

    on_autoload_no_session = function()
      vim.notify('No existing session to load.')
    end,
    telescope = {                         -- options for the telescope extension
      reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    },
  })
end

return { {
  'olimorris/persisted.nvim',
  config = setup_persisted,
} }
