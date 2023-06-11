local M = {}

---Format config module require path to an absolute path for the file
---@param module string Lua-require module path (module in nvim config)
---@return string
function M.module_to_path(module)
  local config_root = vim.fn.stdpath('config')
  return config_root .. '/lua/' .. M.replace(module, '%.', '/') .. '.lua'
end

---Checks if Lua module exists
---@param module string Name of module
---@return boolean
function M.module_exists(module)
  local ok, _ = pcall(require, module)
  return ok
end

---Clone a file
---@param path string Source path
---@param new_path string Destination path (including rename)
---@return string path Path to new file
function M.clone_file(path, new_path)
  vim.fn.jobstart({ 'cp', path, new_path }, {
    on_stderr = function(_, data)
      print('Error `cp`-ing file')
      print(data)
    end,
  })
  return new_path
end

return M
