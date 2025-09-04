local M = {}


function M.install_packages(packages)
  local registry = require("mason-registry")
  for _, pkg_name in ipairs(packages) do
    local ok, pkg = pcall(registry.get_package, pkg_name)
    if ok then
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end
end

return M
