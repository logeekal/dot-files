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
  vim.cmd('TSBufDisable highlight')
  -- Switching syntax off is only needed in very big file ( > 100M )
  -- vim.cmd('syntax off')
  -- vim.cmd('syntax clear')
  vim.cmd('TSContextDisable')
  -- vim.cmd('IlluminatePauseBuf')
  -- vim.cmd('IndentBlanklineDisable')
  vim.cmd('NoMatchParen')
end

return M
