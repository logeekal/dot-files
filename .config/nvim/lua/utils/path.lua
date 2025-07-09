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

function M.get_git_root()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel")
  if result and #result > 0 then
    -- systemlist returns a table, take the first element
    return result[1]:gsub("\\", "/") -- Normalize path separators for Windows
  end
  return nil
end

-- return project root based on markers. If no markers is found,
-- returned value is Falsy
function M.get_project_root_display()
  -- Define your markers. Adjust these based on your typical project types.
  local project_markers = {
    ".git",           -- Git repositories
    "Cargo.toml",     -- Rust projects
    "package.json",   -- Node.js/JavaScript projects
    "pyproject.toml", -- Python projects (Poetry, Hatch, etc.)
    "Makefile",       -- General build systems
    ".project-root",  -- A custom marker file you might use
    "go.mod",         -- Go modules
    "composer.json",  -- PHP Composer projects
    "stylua.toml"
  }

  -- calculate based on marker's priority

  for _, marker in ipairs(project_markers) do
    -- Check if the marker exists in the current directory or any parent directory
    local path = vim.fs.root(0, marker)
    if path then
      -- If the marker is found, return the directory path
      return path
    end
  end
end

return M
