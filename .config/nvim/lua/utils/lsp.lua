local M = {}

M.lsp_servers = {
  luau_lsp = true,
  eslint = true,
  yamlls = true,
  lua_ls = true,
  rust_analyzer = true,
  bashls = true,
  vimls = true,
  emmet_ls = true,
  cssls = true,
  graphql = true,
  jsonls = true,
  svelte = true,
  tailwindcss = true,
  pylsp = true,
  marksman = true,
  vectorcode_server = false,
  tsgo = false,
  vtsls = true
}

M.style_providers = {
  prettier = true,
  stylua = true,
  rustfmt = true,
  shfmt = true,
  cssfmt = true,
  jsonfmt = true,
  xmlformatter = true,
}

-- Returns a table of enabled LSP servers
-- @param tab A table where keys are LSP server names and values are booleans indicating if the server is enabled
-- @return A table containing the names of enabled LSP servers
-- Example usage:
function M.get_enabled_keys(tab)
  local enabled_keys = {}
  for key, enabled in pairs(tab) do
    if not enabled then
      goto continue
    end
    table.insert(enabled_keys, key)
    ::continue::
  end
  return enabled_keys
end

return M
