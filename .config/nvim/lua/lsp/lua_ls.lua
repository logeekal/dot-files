return {
      cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
  settings = {
    Lua = {
      format = {
        enable = true, -- Enable formatting
        defaultConfig = {
          indent_style = 'space', -- Use spaces for indentation
          indent_size = '2', -- Set indentation size to 2 spaces
        },
      },
      -- Enable the language server to recognize the `vim` global
      runtime = {
        version = 'LuaJIT', -- Use LuaJIT for Neovim compatibility
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false, -- Disable third-party checks for performance
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
}
