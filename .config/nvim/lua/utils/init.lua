local M = {}

M.colors = {
  bg = '#282a2e',
  fg = '#cdcdcd',
  section_bg = '#38393f',
  buffer_bg = '#212026',
  yellow = '#f1fa8c',
  cyan = '#8be9fd',
  green = '#50fa7b',
  orange = '#ffb86c',
  magenta = '#ff79c6',
  blue = '#8be9fd',
  red = '#ff5555',
  purple = '#bc6ec5',
}

-- Taken from https://github.com/LazyVim/LazyVim/blob/6b68378c2c5a6d18b1b4c5ca4c71441997921200/lua/lazyvim/config/init.lua
M.icons = {
  dap = {
    Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '.>',
  },
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}

M.mason_install = function(package_list)
  local registry = require('mason-registry')

  for _, pkg_name in ipairs(package_list) do
    local ok, pkg = pcall(registry.get_package, pkg_name)
    if ok then
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end
end

M.disableSyntaxLargeFile = function()
  vim.api.nvim_echo({ { '[Utils] Starting to disable features...', 'Normal' } }, true, {})

  -- Detach all LSP clients from the buffer
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients > 0 then
    vim.api.nvim_echo({ { string.format('[Utils] Detaching %d LSP client(s)', #clients), 'Normal' } }, true, {})
    for _, client in ipairs(clients) do
      vim.api.nvim_echo({ { string.format('[Utils] Detaching LSP: %s', client.name), 'Normal' } }, true, {})
      vim.lsp.buf_detach_client(buf, client.id)
    end
    vim.api.nvim_echo({ { '[Utils] All LSP clients detached', 'Normal' } }, true, {})
  else
    vim.api.nvim_echo({ { '[Utils] No LSP clients to detach', 'Normal' } }, true, {})
  end

  local success, err = pcall(function()
    vim.cmd('TSBufDisable highlight')
    vim.api.nvim_echo({ { '[Utils] TreeSitter highlight disabled', 'Normal' } }, true, {})
  end)
  if not success then
    vim.api.nvim_echo({ { string.format('[Utils] Failed to disable TS highlight: %s', err), 'WarningMsg' } }, true, {})
  end

  -- Switching syntax off is only needed in very big file ( > 100M )
  -- vim.cmd('syntax off')
  -- vim.cmd('syntax clear')

  success, err = pcall(function()
    vim.cmd('TSContextDisable')
    vim.api.nvim_echo({ { '[Utils] TSContext disabled', 'Normal' } }, true, {})
  end)
  if not success then
    vim.api.nvim_echo({ { string.format('[Utils] Failed to disable TSContext: %s', err), 'WarningMsg' } }, true, {})
  end

  -- vim.cmd('IlluminatePauseBuf')
  -- vim.cmd('IndentBlanklineDisable')

  success, err = pcall(function()
    vim.cmd('NoMatchParen')
    vim.api.nvim_echo({ { '[Utils] MatchParen disabled', 'Normal' } }, true, {})
  end)
  if not success then
    vim.api.nvim_echo({ { string.format('[Utils] Failed to disable MatchParen: %s', err), 'WarningMsg' } }, true, {})
  end

  vim.api.nvim_echo({ { '[Utils] All features disabled successfully', 'Normal' } }, true, {})
end

return M
